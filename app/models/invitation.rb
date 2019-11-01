class Invitation < ApplicationRecord
  belongs_to :project

  attr_accessor :send_invite_email
end
