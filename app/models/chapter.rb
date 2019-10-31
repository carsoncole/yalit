require 'kramdown'

class Chapter < ApplicationRecord
  # after_initialize :set_defaults!, unless: proc{ |c| c.is_persisted? }

  belongs_to :project
  has_many :sections, dependent: :destroy
  has_many :sub_sections, through: :sections
  validates :title, presence: true
  # validates :rank, presence: true
  # validates :rank, uniqueness: truer

  # before_validation :set_rank!, if: proc{ |c| c.rank.nil? }

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
