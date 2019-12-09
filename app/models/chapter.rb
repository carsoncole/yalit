require "kramdown"

class Chapter < ApplicationRecord
  belongs_to :project
  has_many :sections, dependent: :destroy
  has_many :sub_sections, through: :sections
  validates :title, presence: true
  before_save :set_rank!, if: proc { |c| c.rank.blank? }

  def set_rank!
    chapters = project.chapters.where.not(rank: nil).order(rank: :asc)
    self.rank = if chapters.any?
      chapters.last.rank + 1
    else
      1
    end
  end
end
