class Project < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :invitations, dependent: :destroy
  has_many :servers, dependent: :destroy

  attr_accessor :generate_default_content

  after_create :generate_content!, if: proc{ |p| p.generate_default_content }

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
    rights && rights.role == 'owner' ? true : false
  end

  def first_chapter
    chapters.order(rank: :asc).first
  end

  #TODO Add more key/values to complete schema
  # This schema is based on https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md
  def schema
    if servers.any?
      servers_array = servers.all.map {|s| "'url': #{s.url}, 'description': '#{s.description}'" }.join(", ")
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
        "path":""
    }
  end

  #OPTIMIZE Refactor to use rank key-value so this will work with any number of ranks
  def admin_or_higher?(user)
    rights = user_projects.find_by(user: user)
    rights && ['owner', 'admin'].include?(rights.role) ? true : false
  end

  def editor?(user)
    rights = user_projects.find_by(user: user)
    rights && ['editor'].include?(rights.role) ? true : false
  end

  #TODO Add more default content
  def generate_content!(file='lib/gradeus_content.yml')
    content = YAML.load_file(file)

    content['chapters'].each do |chapter|
      new_chapter= chapters.create(title: chapter['title'], content: chapter['content'], rank: chapter['rank'])
      if chapter['sections']
        chapter['sections'].each do |section|
          new_section = new_chapter.sections.create(title: section['title'], rank: section['rank'], is_resource: section['is_resource'])
          if section['request_methods']
            section['request_methods'].each do |method|
              new_section.request_methods.create(title: method['title'], description: method['description'], verb: method['verb'], url: method['url'])
            end
          end
        end
      end
    end
  end
end
