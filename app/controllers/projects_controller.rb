class ProjectsController < ApplicationController
  before_action :require_login
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  #TODO Redirect to a welcome page if no projects exist
  def index
    @projects = current_user.projects
  end

  def show
    @user_projects = @project.user_projects.includes(:user).order(role: :desc)
    @invitations = @project.invitations.all
    @invitation = @project.invitations.new
    session[:project_id] = @project.id
    if params[:view]
      first_chapter = @project.chapters.order(rank: :asc).first
      unless first_chapter
        first_chapter = @project.chapters.create(title: "Default")
      end
      redirect_to chapter_path(first_chapter) if first_chapter
    end
  end

  #TODO Fix for Postman importing
  def schema
    @project = current_user.projects.find(params[:project_id])
    @schema = @project.schema
    if params[:download]
      send_data(JSON.pretty_generate(@schema), filename: "schema.yml", type: "text/html")
    end
  end

  #FIXME This path is broken
  def new
    @project = Project.new
  end

  #TODO Add popup messages to be more helpful
  def edit
  end

  def toggle_is_published
    @project = Project.find(params[:project_id])
    if @project.host_name.present? || @project.is_published
      @project.toggle(:is_published)
      @project.save
      redirect_to project_path(@project), notice: "Your project API docs are #{ @project.is_published? ? "now" : "no longer" } showing on https://#{@project.host_name}."
    else
      redirect_to project_path(@project), alert: "A host name must be added to publish."
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.build(project_params)
    @project.user_projects.build(user: current_user)


    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :host_name, :ssl_endpoint_domain, :color, :description, :terms_of_service_url, :contact_name, :contact_email, :contact_url, :license_name, :license_url, :version, :generate_default_content, :heroku_acm_status, :heroku_cname)
    end
end
