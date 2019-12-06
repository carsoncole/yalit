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
      server = project.ping_server
      api_key = server.api_key
      request = server.url + path
      update(request_content: verb.upcase + ' ' + request)
      headers = {}
      headers = headers.merge({ "Authorization" => server.authorization_header }) if server.authorization_header.present?
      headers = headers.merge({ "Content-Type" => server.content_type_header}) if server.authorization_header.present?
      response = HTTParty.get(request, headers: headers)
      update(response_content: response.body, response_code: response.code)
    end
  end
end
