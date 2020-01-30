class RequestMethod < ApplicationRecord
  include HTTParty
  VERBS = ["get", "post", "delete", "put", "patch"]

  belongs_to :section
  has_many :parameters, dependent: :destroy

  validates :path, presence: true
  validates :description, presence: true
  validates :verb, inclusion: { in: VERBS,
    message: "%{value} is not a valid HTTP verb" }

  before_validation :downcase_verb!, if: proc { |rm| rm.verb_changed? || !rm.persisted? }

  def downcase_verb!
    self.verb = verb.downcase if verb.present?
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
      result = path.dup
      params_with_values.each do |pv|
        next if pv[1].nil?
        result.gsub!(pv[0], pv[1])
      end
      result
    else
      nil
    end
  end

  def curl
    result = case verb
    when "post"
      "curl -d #{params_encoded || "" } #{full_url}"
    when "get"
      "curl #{full_url}"
    when "patch", "put"
      "curl -d #{params_encoded || "" } #{full_url}"
    when "delete"
      "curl #{full_url}"
    end
    result + ' -H "Authorization: API-KEY"'
  end

  def params_encoded
    result = ""
    parameters_hash.each do |key, value|
      result += "#{key}=#{value}&"
    end
    encoded = URI::encode(result.chomp('&')) rescue nil
    if encoded
      '"' + encoded + '"'
    else
      nil
    end
  end

  def params_in_path
    if path.present?
      params_with_brackets = path.scan(/{[a-zA-Z0-9_.-]*}/)
      params = []
      params_with_brackets.each do |p|
        parameter = parameters.find_by(key: p.gsub("{","").gsub("}",""))
        params << parameter.key if parameter
      end
      params
    else
      nil
    end
  end

  def full_url
    if project && project.ping_server
      server = project.ping_server
      server.url + full_path || ""
    else
      nil
    end
  end

  def ping!
    if project && project.ping_server
      server = project.ping_server
      request = full_url
      headers = {}
      headers = headers.merge({ "Authorization" => server.authorization_header }) if server.authorization_header.present?
      headers = headers.merge({ "Content-Type" => server.content_type_header}) if server.content_type_header.present?
      full_content = verb.upcase + ' ' + request
      begin
        case verb
        when 'get'
          if parameters_hash.empty?
            response = HTTParty.get(request, headers: headers)
          else
            response = HTTParty.get(request, headers: headers, query: parameters_hash)
            full_content += '  params: ' + parameters_hash.to_json
          end
        when 'post'
          response = HTTParty.post(request, headers: headers, body: parameters_hash.to_json)
          full_content += '  body: ' + parameters_hash.to_json
        when 'delete'
          response = HTTParty.delete(request, headers: headers)
        when 'put'
          response = HTTParty.put(request, headers: headers, body: parameters_hash.to_json)
          full_content += '  body: ' + parameters_hash.to_json
        when 'patch'
          response = HTTParty.patch(request, headers: headers, body: parameters_hash.to_json)
          full_content += '  body: ' + parameters_hash.to_json
        end
      rescue => e
        response = nil
      end
      update(request_content: full_content)
      update(response_code: response.nil? ? nil : response.code, response_body: response.nil? ? "Server failure (Possibly a bad server url)" : response.body
      )
    end
  end

  def parameters_hash
    result = {}
    parameters.each do |param|
      next if params_in_path.include? param.key
      next unless param.value.present?
      result[param.key.to_sym] = JSON.parse(param.value) rescue param.value
    end
    result
  end
end
