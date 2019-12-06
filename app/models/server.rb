#TODO Add callback to ensure only one server is used for testing
class Server < ApplicationRecord
  belongs_to :project

  validates :url, presence: true
  validates :description, presence: true
end
