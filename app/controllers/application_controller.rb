class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_project
  before_action :set_editing_mode

  def set_project
    @project = Project.last
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
