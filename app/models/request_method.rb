class RequestMethod < ApplicationRecord
  include HTTParty
  VERBS = ["GET", "POST", "DELETE", "PATCH"]

  belongs_to :section
  has_many :parameters

  validates :path, presence: true
  validates :description, presence: true
  validates :verb, inclusion: { in: VERBS,
    message: "%{value} is not a valid HTTP verb" }

  before_validation :upcase_verb!, if: proc { |rm| rm.verb_changed? || !rm.persisted? }

  def upcase_verb!
    self.verb = verb.upcase if verb.present?
  end

  def project
    section.chapter.project
  end

  def full_path
    if path.present?
      params = path.scan(/{[a-zA-Z0-9_.-]*}/)
      params_with_values = []
      params.each do |p|
        parameter = parameters.find_by(key: p.gsub("{","").gsub("}",""))
        params_with_values << [p, parameter&.value]
      end
      result = path
      params_with_values.each do |pv|
        next if pv[1].nil?
        result.gsub!(pv[0], pv[1])
      end
      result
    else
      nil
    end
  end

  def ping!
    if project && project.ping_server
      server = project.ping_server
      request = server.url + full_path || ""
      update(request_content: verb.upcase + ' ' + request)
      headers = {}
      headers = headers.merge({ "Authorization" => server.authorization_header }) if server.authorization_header.present?
      headers = headers.merge({ "Content-Type" => server.content_type_header}) if server.authorization_header.present?
      begin
        if verb == 'GET'
          response = HTTParty.get(request, headers: headers)
        elsif verb == 'POST'
          response = HTTParty.post(request, headers: headers)
        elsif verb == 'DELETE'
          response = HTTParty.delete(request, headers: headers)
        end
      rescue => e
        response = nil
      end
      update(
        response_content: response.nil? ? "Failed" : response.body,
        response_code: response.nil? ? nil : response.code,
        response_body: response.nil? ? "Server failure (Possibly a bad server url)" : response.body
        )
    end
  end
end
