class Section < ApplicationRecord
  belongs_to :chapter
  has_many :sub_sections, dependent: :destroy
  has_many :request_methods, dependent: :destroy

  before_save :set_rank!, if: proc{ |c| c.rank.nil? }

  def set_rank!
    sections = chapter.sections.where.not(rank: nil).order(rank: :asc)
    self.rank = if sections.any?
      sections.last.rank + 1
    else
      1
    end
  end
end
