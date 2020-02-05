class RequestMethodsController < ApplicationController
  before_action :require_login
  before_action :set_chapter, except: [:new, :create, :ping]
  before_action :set_section, except: [:new, :create]
  before_action :set_request_method, only: [:show, :edit, :update, :ping, :destroy]

  # GET /request_methods
  # GET /request_methods.json
  def index
    @request_methods = RequestMethod.all
  end

  # GET /request_methods/1
  # GET /request_methods/1.json
  def show
  end

  # GET /request_methods/new
  def new
    @request_method = RequestMethod.new
    chapter_ids = @project.chapters.select(:id)
    @sections = Section.where(chapter_id: chapter_ids)
  end

  # GET /request_methods/1/edit
  def edit
    @sections = @chapter.sections
  end

  def ping
    @request_method.ping!
    redirect_to chapter_path(@request_method.section.chapter, anchor: @request_method.title.parameterize), data: { turbolinks: false }, notice: "Successfully pinged endpoint."
  end

  # POST /request_methods
  # POST /request_methods.json
  def create
    @section = Section.find(params[:request_method][:section_id])
    @chapter = @section.chapter
    @request_method = @section.request_methods.new(request_method_params)
    @sections = @chapter.sections

    respond_to do |format|
      if @request_method.save
        format.html { redirect_to chapter_path(@chapter.id), notice: "Sub section was successfully created." }
        format.json { render :show, status: :created, location: @request_method }
      else
        format.html { render :new }
        format.json { render json: @request_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @chapter = @request_method.section.chapter
    respond_to do |format|
      if @request_method.update(request_method_params)
        format.html { redirect_to chapter_path(@chapter, anchor: @request_method.title.parameterize), notice: "Sub section was successfully updated." }
        format.json { render :show, status: :ok, location: @request_method }
      else
        format.html { render :edit }
        format.json { render json: @request_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request_method.destroy
    respond_to do |format|
      format.html { redirect_to @chapter, notice: "Request method was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_chapter
      @chapter = Chapter.find(params[:chapter_id]) if params[:chapter_id]
    end

    def set_section
      @section = Section.find(params[:section_id]) if params[:section_id]
    end

    def set_request_method
      if params[:request_method_id]
        @request_method = RequestMethod.find(params[:request_method_id])
      else
        @request_method = RequestMethod.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_method_params
      params.require(:request_method).permit(:section_id, :title, :request_content, :response_content, :content, :rank, :verb, :path, :description, :response_code, :response_body, :send_object_name, :send_as_array)
    end
end
