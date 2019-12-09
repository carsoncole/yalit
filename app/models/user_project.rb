class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def self.roles
    %w(owner admin editor)
  end

  validates :role, inclusion: { in: UserProject.roles }
  validates :user_id, uniqueness: { scope: :project_id }
  validates :role, uniqueness: { scope: :project_id }, if: proc { |up| up.role == 'owner' }

  validate :check_if_role_changing_from_owner


  def initialize(args)
    super
    self.role = "owner" unless role.present?
  end

  def check_if_role_changing_from_owner
    if self.role_changed? && self.role_was == 'owner'
      errors.add(:role, "Ownership can not be removed")
    end
  end
end
