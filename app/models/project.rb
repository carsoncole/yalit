class Project < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :invitations, dependent: :destroy

  def initialize(args)
    super
    self.color = "#007bff"
    self.version = "1.0.0"
    self.license_name = "Apache 2.0"
    self.license_url = "http://www.apache.org/licenses/LICENSE-2.0.html"
  end

  def owner?(user)
    rights = user_projects.find_by(user: user)
    rights && rights.role == 'owner' ? true : false
  end

  def schema
    {
      "title": name,
      "description": description,
      "termsOfService": terms_of_service_url,
      "contact": {
        "name": contact_name,
        "url": contact_url,
        "email": contact_email
      },
      "license": {
        "name": license_name,
        "url": license_url
      },
      "version": version
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
end
