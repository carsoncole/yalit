class SubSection < ApplicationRecord
  belongs_to :section

  before_save :set_rank!, if: proc{ |c| c.rank.nil? }

  def set_rank!
    sub_sections = section.sub_sections.where.not(rank: nil).order(rank: :asc)
    self.rank = if sub_sections.any?
      sub_sections.last.rank + 1
    else
      1
    end
  end
end
