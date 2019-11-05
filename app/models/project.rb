#TODO Fix how having a domain should have it present, but offline for maintenance
class Project < ApplicationRecord
  require "platform-api"

  has_many :chapters, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :invitations, dependent: :destroy
  has_many :servers, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :version, presence: true

  validates :host_name, uniqueness: true, if: proc { |p| p.host_name.present? }

  validates :host_name, format: { without: /\Ahttp[s]?/,
    message: "should not be preceded with http(s)" }, if: proc { |p| p.host_name.present? }

  validates :host_name, format: { with: /\A[0-9A-Za-z\.\-]+\z/,
    message: "should not have any special characters" }, if: proc { |p| p.host_name.present? && p.host_name != 'localhost:3000' }

  validates :host_name, format: { with: /\A.+\..+\z/,
    message: "should be a complete host name" }, if: proc { |p| p.host_name.present? && p.host_name != 'localhost:3000' }

  attr_accessor :generate_default_content

  after_create :generate_content!, if: proc { |p| p.generate_default_content }

  # before_save :update_hostname_on_heroku!, if: proc { |p| p.is_hosted_changed? }

  def initialize(args)
    super
    self.color = "#007bff"
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
    Schema.new(self).open_api
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
    if is_hosted_changed? && is_hosted_was.blank?
      result = heroku_find_or_create_host_name
      self.heroku_acm_status = result["acm_status"]
      self.heroku_cname = result["cname"]
      self.heroku_acm_status_reason = result["acm_status_reason"]
      self.heroku_acm_created_at = result["created_at"]
      self.heroku_acm_updated_at = result["updated_at"]
      self.heroku_acm_id = result["id"]
      self.heroku_domain_status = result["status"]
    elsif host_name_changed? && host_name.blank?
      heroku_destroy_host_name
    end
  end

  def heroku_get_domain_status!
    return unless host_name.present?
    heroku = Heroku.new.client
    result = heroku.domain.info('yalit-staging',host_name) rescue nil
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

  def heroku_find_or_create_host_name
    # return nil unless ENV["HEROKU_APP_NAME"]
    heroku = Heroku.new.client
    # heroku.domain.info(ENV["HEROKU_APP_NAME"],host_name)
    heroku.domain.info('yalit-staging',host_name)
  rescue Excon::Error::NotFound
    # heroku.domain.create(ENV["HEROKU_APP_NAME"], { hostname: host_name })
    response = heroku.domain.create('yalit-staging', { hostname: host_name })
    puts "*"*80
    puts response
    response
  end

  def heroku_destroy_host_name
    # return nil unless ENV["HEROKU_APP_NAME"]
    self.heroku_acm_status = nil
    self.heroku_cname = nil
    self.heroku_acm_status_reason = nil
    self.heroku_acm_created_at = nil
    self.heroku_acm_updated_at = nil
    self.heroku_acm_id = nil
    self.heroku_domain_status = nil
    heroku = Heroku.new.client
    # result = heroku.domain.delete(ENV["HEROKU_APP_NAME"], host_name)
    result = heroku.domain.delete('yalit-staging', host_name_changed? ? host_name_was : host_name)
    puts result
  rescue Excon::Error::NotFound => e
    puts"!"*80
    puts e
  end

  #TODO Add more default content
  def generate_content!(file = "lib/default_content.yml")
    content = YAML.load_file(file)

    content["chapters"].each do |chapter|
      new_chapter= chapters.create(title: chapter["title"], content: chapter["content"], rank: chapter["rank"])
      if chapter["sections"]
        chapter["sections"].each do |section|
          new_section = new_chapter.sections.create(title: section["title"], rank: section["rank"], is_resource: section["is_resource"])
          if section["request_methods"]
            section["request_methods"].each do |method|
              new_section.request_methods.create(title: method["title"], request_content: method["description"], verb: method["verb"], url: method["url"])
            end
          end
        end
      end
    end
  end
end
