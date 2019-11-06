class InvitationsController < ApplicationController
  before_action :require_login
  before_action :set_project

  def create
    @invitation = @project.invitations.create(
      email: params[:invitation][:email].downcase,
      role: params[:invitation][:role]
      )
    redirect_to project_path(@project)
  end

  def destroy
    @invitation = @project.invitations.find_by(params[:id])
    @invitation.destroy
    redirect_to project_path(@project)
  end

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end
end
