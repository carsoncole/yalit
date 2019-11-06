class RequestMethod < ApplicationRecord
  VERBS = ["get", "post", "delete", "patch"]

  belongs_to :section
  belongs_to :project, optional: true

  validates :path, presence: true
  validates :description, presence: true

  before_save :downcase_verb!, if: proc { |rm| rm.verb_changed? || !rm.persisted? }

  def downcase_verb!
    self.verb = verb.downcase
  end
end
