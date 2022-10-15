class User < ApplicationRecord
  include Clearance::User

  has_many :user_projects
  has_many :projects, through: :user_projects

  before_destroy :delete_owned_projects_if_unowned!

  def delete_owned_projects_if_unowned!
    ups = user_projects.where(role: 'owner')
    ups.each do |up|
      unless up.project.users.where.not(id: self.id).any?
        project = up.project
        up.destroy
        project.destroy
      end
    end
  end

  def owner?(project)
    user_projects.find_by(project: project).role == 'owner'
  end

  def owner_or_admin?(project)
    ['owner', 'admin'].include? user_projects.find_by(project: project).role
  end

  def user?(project)
    ['user'].include? user_projects.find_by(project: project).role
  end
end
