class ErrorCode < ApplicationRecord
  belongs_to :section

  validates :title, :http_status_code, :custom_status_code, :message, presence: :true
end
