class Project < ApplicationRecord
  has_many :chapters, dependent: :destroy
end
