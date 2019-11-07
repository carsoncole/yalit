#TODO Add more key/values to complete schema
# This schema is based on https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md
class Schema

  attr_accessor :project

  def initialize(project)
    self.project = project
    self
  end

  #TODO This needs to be further worked on
  def compliant?
    valid = true
    valid = false unless open_api[:openapi].present?
    valid = false unless open_api[:info].present?
    valid = false unless open_api[:servers].present?
    valid = false unless open_api[:paths].present?
    valid
  end

  def open_api
    result = {}
    result.merge!(openapi: openapi_version)
    result.merge!({info: info})
    result.merge!({ servers: servers })
    result.merge!({ paths: paths })
    result
  end

  def openapi_version
    "3.0.3"
  end

  def info
    result = {}
    result.merge!({ "title": @project.name })
    result.merge!({ "description": @project.description })
    result.merge!({ "termsOfService": @project.terms_of_service_url }) if @project.terms_of_service_url.present?
    result.merge!({ contact: contact })
    result.merge!({ license: license })
    result.merge!({ version: @project.version })
    result
  end

  def contact
    result = {}
    result.merge!({:name => @project.contact_name}) if @project.contact_name.present?
    result.merge!({ :url =>  @project.contact_url}) if @project.contact_url.present?
    result.merge!({ :email=> @project.contact_email}) if @project.contact_email.present?
    result
  end

  def license
    result = {}
    result.merge!({ "name": @project.license_name }) if @project.license_name.present?
    result.merge!({ "url": @project.license_url }) if @project.license_url.present?
    result
  end

  def servers
    result = []
    servers_array = @project.servers.all
    servers_array.each do |server|
      result << {
        "url": server.url,
        "description": server.description
      }
    end
    result
  end

  #FIXME Important! This remains broken
  def paths
    result = {}
    chapter_ids = project.chapters.select(:id)
    section_ids = Section.where(chapter_id: chapter_ids).select(:id)
    @rms = RequestMethod.where(section_id: section_ids)
    
    paths_1 = @rms.pluck(:path).uniq

    paths_1.each do |path|
      result.merge!({ "#{path}":  verbs_payload(path) })
    end

    result.merge!("parameters": { "name": "user_uuid", "in": "path", "description": "username to fetch", "required": true, "schema": { "type": "string"} })
    result
  end

  def verbs_payload(path)
    result = {}
    path_rms = @rms.where(path: path)
    path_rms.each do |rm|
      result.merge!({ rm.verb.to_sym => {"description" => "some desc", "responses" => responses_payload(rm) } })
    end
    result
  end

  def responses_payload(rm)
    result = {}
    result.merge!({ "200": { "content" => {"application/json" => {}  }, "description" => "some description" }})
    result
  end

  def application_json_payload
  end





end
