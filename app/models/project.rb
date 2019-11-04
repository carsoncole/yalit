#TODO Connect to Heroku API for configuring SSL

#TODO Fix how having a domain should have it present, but offline for maintenance
class Project < ApplicationRecord
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
    message: "should not have any special characters" }, if: proc { |p| p.host_name.present? }

  attr_accessor :generate_default_content

  after_create :generate_content!, if: proc { |p| p.generate_default_content }

  before_save :update_hostname_on_heroku!, if: proc { |p| p.host_name_changed? }

  def initialize(args)
    super
    self.color = "#007bff"
    self.version = "1.0.0"
    self.contact_email = "contact@example.com"
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

  #TODO Add more key/values to complete schema
  # This schema is based on https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md
  def schema
    if servers.any?
      servers_array = servers.all.map { |s| "'url': #{s.url}, 'description': '#{s.description}'" }.join(", ")
    else
      servers_array = nil
    end
    {
      "openapi": "3.0.0",
      "info": {
        "title": name,
        "description": description,
        "termsOfService": terms_of_service_url ? terms_of_service_url : "",
        "contact": {
          "name": contact_name ? contact_name : "",
          "url": contact_url ? contact_url : "",
          "email": contact_email.present? ? contact_email : "contact@example.com",
        },
        "license": {
          "name": license_name,
          "url": license_url
        },
        "version": version
      },
        "servers": [ servers_array ],
        "path": ""
    }
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
    if host_name_changed? && host_name_was.blank?
      heroku_find_or_create_host_name
    elsif host_name_changed? && host_name.blank?
      heroku_destroy_host_name
    end
  end

  def heroku_find_or_create_host_name
    return nil unless ENV["HEROKU_APP_NAME"]
    heroku = Heroku.new.client
    heroku.domain.info(ENV["HEROKU_APP_NAME"],host_name)
  rescue Excon::Error::NotFound
    heroku.domain.create(ENV["HEROKU_APP_NAME"], { hostname: host_name })
  end

  def heroku_destroy_host_name
    return nil unless ENV["HEROKU_APP_NAME"]
    heroku = Heroku.new.client
    heroku.domain.delete(ENV["HEROKU_APP_NAME"], host_name)
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
              new_section.request_methods.create(title: method["title"], description: method["description"], verb: method["verb"], url: method["url"])
            end
          end
        end
      end
    end
  end
end
