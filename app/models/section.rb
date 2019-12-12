#TODO Add jobs for pinging for error codes
#TODO Add popover for details on integrating external errors
class Section < ApplicationRecord
  belongs_to :chapter
  has_many :sub_sections, dependent: :destroy
  has_many :request_methods, dependent: :destroy
  has_many :error_codes, dependent: :destroy

  before_save :set_rank!, if: proc { |c| c.rank.blank? }

  def set_rank!
    sections = chapter.sections.where.not(rank: nil).order(rank: :asc)
    self.rank = if sections.any?
      sections.last.rank + 1
    else
      1
    end
  end

  def ping_for_error_codes!
    if is_error_codes && error_endpoint_path.present?
      server = chapter.project.ping_server
      request = server.url + error_endpoint_path
      headers = {}
      headers = headers.merge({ "Authorization" => server.authorization_header }) if server.authorization_header.present?
      headers = headers.merge({ "Content-Type" => server.content_type_header}) if server.authorization_header.present?
      begin
        response = HTTParty.get(request, headers: headers)
      rescue => e
        response = nil
      end
      json_response = response.parsed_response
      if response && response.code == 200 && json_response["errors"].class == Array
        error_codes.destroy_all
        json_response["errors"].each do |error_code|
          error = error_codes.new
          error.title = error_code["name"]
          error.http_status_code = error_code["http_status_code"]
          error.custom_status_code = error_code["error_code"]
          error.message = error_code["message"]
          error.save
        end
      end
    end
      nil
  end
end
