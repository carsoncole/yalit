class User < ApplicationRecord
  include Clearance::User
  has_many :user_projects
  has_many :projects, through: :user_projects
end
