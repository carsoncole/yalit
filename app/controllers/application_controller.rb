#TODO Add home page (not logged in) and fix top banner for not logged in
#TODO Add a maintenance mode
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_project, except: [:not_found]
  before_action :set_editing_mode

  def set_project
    if hosted_site
      @project = hosted_site
      @hosted = true
    else
      @project = if session[:project_id]
        Project.find_by(id: session[:project_id])
      end
    end
    puts "%"*80
    puts request.host
    puts @project
    puts root_site?
    puts params
    redirect_to not_found_path unless @project && root_site?
  end

  def hosted_site
    Project.where(host_name: request.host_with_port).first
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

