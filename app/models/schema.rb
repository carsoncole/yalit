#TODO Add more key/values to complete schema
# This schema is based on https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md
class Schema

  attr_accessor :project, :open_api

  def initialize(project)
    self.project = project
    self.open_api = self.schema_minimum.to_h.merge! info
    self.open_api.merge! servers
    self
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

end
