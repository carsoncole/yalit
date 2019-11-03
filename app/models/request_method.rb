class RequestMethod < ApplicationRecord
  VERBS = ["GET", "POST", "PUT", "DELETE", "PATCH"]

  belongs_to :section
end
