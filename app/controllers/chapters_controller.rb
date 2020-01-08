class ChaptersController < ApplicationController
  before_action :require_login, except: [:show, :schema]
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  def index
    @chapters = Chapter.all
  end

  #TODO Fix side nav background height 100%
  def show
    @next_chapter = @project.chapters.where("rank > ?", @chapter.rank).order(rank: :asc).limit(1)
    @previous_chapter = @project.chapters.where("rank < ?", @chapter.rank).order(rank: :desc).limit(1)
    @chapters = @project.chapters
    @sections = @chapter.sections.includes(:request_methods, :sub_sections).order(rank: :asc)
  end

  def new
    @chapters = @project.chapters
    @chapter = @project.chapters.build
  end

  def edit
  end

  #TODO Fix for Postman importing
  def schema
    # @project = current_user.projects.find(params[:project_id])
    @chapters = @project.chapters
    @schema = @project.schema.open_api
    if params[:download]
      send_data(JSON.pretty_generate(@schema), filename: "openapi.json") and return
    end

    respond_to do |format|
      format.html {render :schema }
      format.json { render json: @schema}
    end
  end

  def create
    @chapter = @project.chapters.new(chapter_params)

    respond_to do |format|
      if @chapter.save
        format.html { redirect_to @chapter, notice: "Chapter was successfully created." }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to @chapter, notice: "Chapter was successfully updated." }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { render :edit }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to chapter_path(@project.first_chapter), notice: "Chapter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    def chapter_params
      params.require(:chapter).permit(:project_id, :title, :content, :rank)
    end
end
