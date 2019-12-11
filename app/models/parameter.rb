class Parameter < ApplicationRecord
  belongs_to :request_method

  validates :key, :value, presence: true
  validates :key, uniqueness: { scope: :request_method, case_sensitive: false, message: "should have unique keys" }
end
