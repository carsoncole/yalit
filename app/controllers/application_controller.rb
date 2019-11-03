#TODO Add home page (not logged in) and fix top banner for not logged in
#TODO Add a maintenance mode
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_project
  before_action :set_editing_mode

  def set_project
    hosted_project = Project.where(host_name: request.host_with_port).first
    if hosted_project
      @project = hosted_project
      @hosted = true
      unless controller_name == 'chapters'
        redirect_to chapter_path(@project.first_chapter)
      end
    else
      @project = if session[:project_id]
        Project.find_by(id: session[:project_id])
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
