class RequestMethod < ApplicationRecord
  VERBS = ["GET", "POST", "PUT", "DELETE", "PATCH"]

  belongs_to :section
  belongs_to :project, optional: true

  validates :path, presence: true
  validates :description, presence: true
end
