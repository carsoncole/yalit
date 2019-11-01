class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def self.roles
    %w(owner admin editor)
  end

  validates :role, inclusion: { in: UserProject.roles }
  validate :check_for_only_one_owner, if: proc{ |up| up.role == 'owner' }
  validates :user_id, uniqueness: { scope: :project_id }

  def check_for_only_one_owner
    user_projects = project.user_projects.where(role: 'owner')
    if user_projects.count > 1
      errors.add(:role, "can't add more than one owner")
    end
  end
end
