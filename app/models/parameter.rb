class Parameter < ApplicationRecord
  belongs_to :request_method

  FIELD_TYPES = ['String', 'Array', 'Bool']

  validates :key, uniqueness: { scope: :request_method, case_sensitive: false, message: "should have unique keys" }, if: proc { key.present? }
  validates :field_type, presence: true
end
