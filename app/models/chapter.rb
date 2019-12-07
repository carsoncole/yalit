require "kramdown"

class Chapter < ApplicationRecord
  belongs_to :project
  has_many :sections, dependent: :destroy
  has_many :sub_sections, through: :sections
  validates :title, presence: true

  def set_defaults!
    last_ranked_chapter = project.chapters.where.not(id: nil, rank: nil).order(rank: :asc).last
    self.rank = last_ranked_chapter ? last_ranked_chapter.rank + 1 : 1
  end

  def set_rank!
    chapters = project.chapters.where.not(rank: nil).order(rank: :asc)
    self.rank = if chapters.any?
      chapters.last.rank + 1
    else
      1
    end
  end
end
