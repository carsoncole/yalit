class Server < ApplicationRecord
  belongs_to :project

  validates :url, presence: true
  validates :description, presence: true
end
