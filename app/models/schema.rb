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
    result = schema_minimum.to_h.merge! info
    result.merge! servers
    result.merge! paths
    result
  end

  def schema_minimum
    {
      "openapi": "3.0.3",
      "info": {
        "title": @project.name,
        "version": @project.version
      },
      "servers": [
      ],
      "paths": {}
    }
  end

  def info
    result = { :info => schema_minimum[:info] }
    result[:info]["description"] = @project.description if @project.description.present?
    result[:info]["terms_of_service"] = @project.terms_of_service_url if @project.terms_of_service_url.present?
    result[:info]["description"] = @project.description if @project.description
    if @project.contact_name || @project.contact_url || @project.contact_email
      result[:info]["contact"] = {}
      result[:info]["contact"]["name"] = @project.contact_name if @project.contact_name.present?
      result[:info]["contact"]["url"] = @project.contact_url if @project.contact_url.present?
      result[:info]["contact"]["email"] = @project.contact_email if @project.contact_email.present?
    end
    if @project.license_name.present? || project.license_url.present?
      result[:info]["license"] = {}
      result[:info]["license"]["name"] = @project.license_name if @project.license_name.present?
      result[:info]["license"]["url"] = @project.license_url if @project.license_url.present?
    end
    result
  end

  def servers
    result = { :servers => [] }
    servers_array = @project.servers.all
    servers_array.each do |server|
      result[:servers] << {
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
      result.merge!({ path.to_sym => verbs_payload(path) })
    end

    puts "&"*50
    puts result

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
    result.merge!({ "200": { "content": {"application/json": {}  } }})
    result
  end

  def application_json_payload
  end





end
