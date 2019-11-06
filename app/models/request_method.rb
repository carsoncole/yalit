class RequestMethod < ApplicationRecord
  VERBS = ["get", "post", "put", "delete", "patch"]

  belongs_to :section
  belongs_to :project, optional: true

  validates :path, presence: true
  validates :description, presence: true
end
