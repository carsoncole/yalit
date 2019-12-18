#TODO Fix how having a domain should have it present, but offline for maintenance
#FIXME Need to protect against deleting or changing host_name while active
class Project < ApplicationRecord
  require "platform-api"

  has_many :chapters, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :invitations, dependent: :destroy
  has_many :servers, dependent: :destroy

  validates :title, presence: true
  validates :color, format: { with: /\A#(?:[A-F0-9]{3}){1,2}\z/i, message: "requires a hex value" }
  validate :is_hosted_needs_host_name

  validates :host_name, uniqueness: true, if: proc { |p| p.host_name.present? }

  validates :host_name, format: { without: /\Ahttp[s]?/,
    message: "should not be preceded with http(s)" }, if: proc { |p| p.host_name.present? }

  validates :host_name, format: { with: /\A[0-9A-Za-z\.\-]+\z/,
    message: "should not have any special characters" }, if: proc { |p| p.host_name.present? && p.host_name != 'localhost:3000' }

  validates :host_name, format: { with: /\A.+\..+\z/,
    message: "should be a complete host name" }, if: proc { |p| p.host_name.present? && p.host_name != 'localhost:3000' }

  attr_accessor :generate_default_content

  after_create :generate_default_content!, if: proc { |p| generate_default_content == '1' }
  after_create :generate_basic_content!, unless: proc { |p| generate_default_content == '1' }
  before_save :disable_hosting_if_host_name_changed!, if: proc { |p| p.host_name_changed? && p.is_hosted? && heroku_configured? }
  before_save :update_hostname_on_heroku!, if: proc { |p| p.is_hosted_changed? && heroku_configured? }
  before_save :set_color_if_blank!, if: proc { |p| p.color.blank? }
  before_destroy :remove_hosting!, if: proc { |p| p.is_hosted? }

  def initialize(args)
    super
    # These defaults ensure basic conformance to OpenAPI requirements
    self.open_api_version = Schema.new(self).openapi_version
    self.color = "#0f4c81"
    self.contact_email = "contact@example.com"
    self.version = "1.0.0"
    self.license_name = "Apache 2.0"
    self.license_url = "http://www.apache.org/licenses/LICENSE-2.0.html"
  end

  def owner?(user)
    rights = user_projects.find_by(user: user)
    rights && rights.role == "owner" ? true : false
  end

  def first_chapter
    chapters.order(rank: :asc).first
  end

  def schema
    Schema.new(self)
  end

  #OPTIMIZE Refactor to use rank key-value so this will work with any number of ranks
  def admin_or_higher?(user)
    rights = user_projects.find_by(user: user)
    rights && ["owner", "admin"].include?(rights.role) ? true : false
  end

  def editor?(user)
    rights = user_projects.find_by(user: user)
    rights && ["editor"].include?(rights.role) ? true : false
  end

  def update_hostname_on_heroku!
    if is_hosted_changed? && is_hosted
      result = heroku_find_or_create_host_name
      return if result.nil?
      self.heroku_acm_status = result["acm_status"]
      self.heroku_cname = result["cname"]
      self.heroku_acm_status_reason = result["acm_status_reason"]
      self.heroku_acm_created_at = result["created_at"]
      self.heroku_acm_updated_at = result["updated_at"]
      self.heroku_acm_id = result["id"]
      self.heroku_domain_status = result["status"]
    else
      heroku_find_and_destroy_host_name
    end
  end

  #TODO Add env variables in credentials file
  def heroku_get_domain_status!
    return nil unless host_name.present?
    heroku = Heroku.new.client
    result = heroku.domain.info(ENV["HEROKU_APP_NAME"],host_name) rescue nil
    if result
      self.heroku_acm_status = result["acm_status"]
      self.heroku_cname = result["cname"]
      self.heroku_acm_status_reason = result["acm_status_reason"]
      self.heroku_acm_created_at = result["created_at"]
      self.heroku_acm_updated_at = result["updated_at"]
      self.heroku_acm_id = result["id"]
      self.heroku_domain_status = result["status"]
      save
    end
  end

  def ping_server
    servers.where(use_for_ping: true).first
  end

  def heroku_configured?
    if ENV["HEROKU_APP_NAME"] && ENV["HEROKU_API_KEY"]
      true
    else
      puts WARNING: "Heroku environment variables not set to access API"
      false
    end
  end

  def heroku_find_or_create_host_name
    heroku = Heroku.new.client
    heroku.domain.info(ENV["HEROKU_APP_NAME"],host_name)

  rescue Excon::Error::NotFound
    response = heroku.domain.create(ENV["HEROKU_APP_NAME"], { hostname: host_name })
    response
  end

  def heroku_find_and_destroy_host_name
    self.heroku_acm_status = nil
    self.heroku_cname = nil
    self.heroku_acm_status_reason = nil
    self.heroku_acm_created_at = nil
    self.heroku_acm_updated_at = nil
    self.heroku_acm_id = nil
    self.heroku_domain_status = nil
    heroku = Heroku.new.client
    heroku.domain.info(ENV["HEROKU_APP_NAME"],host_name)
    # result = heroku.domain.delete(ENV["HEROKU_APP_NAME"], host_name)
    # result = heroku.domain.delete(ENV["HEROKU_APP_NAME"], host_name_changed? ? host_name_was : host_name)
    result = heroku.domain.delete(ENV["HEROKU_APP_NAME"], host_name)
  rescue Excon::Error::NotFound => e
    puts e
  end

  #TODO Add more default content
  def generate_default_content!(file = "lib/default_content.yml")
    content = YAML.load_file(file)

    content["chapters"].each do |chapter|
      new_chapter= chapters.create(title: chapter["title"], content: chapter["content"], rank: chapter["rank"])
      if chapter["sections"]
        chapter["sections"].each do |section|
          new_section = new_chapter.sections.create(title: section["title"], rank: section["rank"], is_resource: section["is_resource"])
          if section["request_methods"]
            section["request_methods"].each do |method|
              new_section.request_methods.create(title: method["title"], request_content: method["request_content"], response_content: method["response_content"], verb: method["verb"], path: method["path"], description: method["description"])
            end
          end
        end
      end
    end
  end

  def generate_basic_content!
    first_chapter = chapters.create(title: "Default")
  end

  def url
    return nil unless host_name
    "https://" + host_name
  end

  def disable_hosting_if_host_name_changed!
    heroku_find_and_destroy_host_name
    self.is_hosted = false
  end

  def is_hosted_needs_host_name
    if is_hosted && host_name.blank?
      errors.add(:is_hosted, "Hosting requires a host name")
    end
  end

  def set_color_if_blank!
    self.color = "#0f4c81" if color.blank?
  end

  def remove_hosting!
    disable_hosting_if_host_name_changed!
  end
end
