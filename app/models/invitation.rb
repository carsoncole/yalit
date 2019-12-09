#TODO Email sending on new invites
class Invitation < ApplicationRecord
  belongs_to :project

  validates :email, :role, presence: true
  validates :email, uniqueness: { scope: :project_id, message: "An invite already exists with this email"}

  attr_accessor :send_invite_email

  def initialize(args)
    super
    self.role = "owner" unless role.present?
  end
end
