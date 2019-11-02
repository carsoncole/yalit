#TODO Add home page (not logged in) and fix top banner for not logged in
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_project
  before_action :set_editing_mode

  def set_project
    hosted_project = Project.where(domain: request.host_with_port).first
    if hosted_project
      @project = hosted_project
      @hosted = true
    else
      @project = if session[:project_id]
        Project.find(session[:project_id])
      end
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
