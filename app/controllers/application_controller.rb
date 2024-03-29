#TODO Fix Editor link in main nav--requires 2 clicks
#TODO Add home page (not logged in) and fix top banner for not logged in
#TODO Add a maintenance mode
#TODO Flash messages don't seem to work--try updating error code
#TODO Fix flash banner related to domain hosting
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_project, except: [:not_found]
  before_action :set_message, except: [:not_found]
  before_action :set_editing_mode

  def set_project
    if hosted_site
      @project = hosted_site
      @hosted = true
    else
      @project = if session[:project_id] && current_user
        Project.find_by(id: session[:project_id])
      end
    end
    # redirect_to not_found_path unless @project && root_site?
  end

  def set_message
    if @project && @project.message.present?
      @message = @project.message
    end
  end

  def hosted_site
    Project.where(is_hosted: true, host_name: request.host_with_port).first
  end

  def root_site?
    if %w( localhost staging.yalit.io www.example.com ).include? request.host
      true
    else
      false
    end
  end

  def set_editing_mode
    if params["editing_mode"]
      if session["editing_mode"] == false
        session["editing_mode"] = true
      else
        session["editing_mode"] = false
      end
    end

    @editing_mode = session["editing_mode"] if session["editing_mode"].present? && session["editing_mode"]
  end
end

