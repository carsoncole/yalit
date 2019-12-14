class ResourceAttribute < ApplicationRecord
  belongs_to :section

  validates :key, presence: true
end
