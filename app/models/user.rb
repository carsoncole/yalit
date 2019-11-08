class User < ApplicationRecord
  include Clearance::User
  has_many :user_projects
  has_many :projects, through: :user_projects

  before_destroy :delete_owned_projects!

  def delete_owned_projects!
    ups = user_projects.where(role: 'owner')
    ups.each do |up|
      UserProject.where(project_id: up.project_id).destroy_all
      up.project.destroy
    end
  end
end
