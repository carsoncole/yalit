class Project < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :invitations, dependent: :destroy

  def owner?(user)
    rights = user_projects.find_by(user: user)
    rights && rights.role == 'owner' ? true : false
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
