class User < ApplicationRecord
  include Clearance::User

  MARTECH_DOMAINS = %w[grade.us reputationloop.com bill4time.com reputology.com gatherup.com].freeze

  has_many :user_projects
  has_many :projects, through: :user_projects

  validate :check_domain_is_martech
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

  def check_domain_is_martech
    unless email.present? && MARTECH_DOMAINS.include?(email.split("@").last)
      errors.add(:email, "is not an allowable email domain")
    end
  end
end
