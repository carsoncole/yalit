class ServersController < ApplicationController
  before_action :require_login
  before_action :set_server, only: [:show, :edit, :update, :destroy]
  def index
    @servers = @project.servers
  end

  def show
  end

  def edit
  end

  def update
    if @server.update(server_params)
      redirect_to project_api_details_path(@project), notice: "Project was successfully updated."
    else
      render :edit
    end
  end

  def new
    @server = @project.servers.build
  end

  def create
    @server = @project.servers.build(server_params)

    respond_to do |format|
      if @server.save
        format.html { redirect_to project_api_details_path(@project), notice: "Server was successfully created." }
        format.json { render :show, status: :created, location: @server }
      else
        format.html { render :new }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @server.destroy
    redirect_to project_api_details_path(@project)
  end

  def set_server
    @server = Server.find(params[:id])
  end

  def server_params
    params.require(:server).permit(:url, :description, :use_for_ping, :content_type_header, :authorization_header)
  end
end
