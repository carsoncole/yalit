class RequestMethod < ApplicationRecord
  include HTTParty
  VERBS = ["get", "post", "delete", "patch"]

  belongs_to :section
  has_many :parameters

  validates :path, presence: true
  validates :description, presence: true

  before_save :downcase_verb!, if: proc { |rm| rm.verb_changed? || !rm.persisted? }

  def downcase_verb!
    self.verb = verb.downcase
  end

  def project
    section.chapter.project
  end

  def ping!
    if project && project.ping_server
      api_key = project.ping_server.api_key
      request = project.ping_server.url + path
      update(request_content: verb.upcase + ' ' + request)
      response = HTTParty.get(request, headers: { "Authorization" => "Token " + api_key })
      update(response_content: response.body, response_code: response.code)
    end
  end
end
