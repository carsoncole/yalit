class SubSectionsController < ApplicationController
  before_action :set_chapter, except: [:new, :create]
  before_action :set_section, except: [:new, :create]
  before_action :set_sub_section, only: [:show, :edit, :update, :destroy]

  # GET /sub_sections
  # GET /sub_sections.json
  def index
    @sub_sections = SubSection.all
  end

  # GET /sub_sections/1
  # GET /sub_sections/1.json
  def show
  end

  # GET /sub_sections/new
  def new
    @sub_section = SubSection.new
    chapter_ids = @project.chapters.select(:id)
    @sections = Section.where(chapter_id: chapter_ids)
  end

  # GET /sub_sections/1/edit
  def edit
    @sections = @chapter.sections
  end

  # POST /sub_sections
  # POST /sub_sections.json
  def create
    @section = Section.find(params[:sub_section][:section_id])
    @chapter = @section.chapter
    @sub_section = @section.sub_sections.new(sub_section_params)

    respond_to do |format|
      if @sub_section.save
        format.html { redirect_to chapter_path(@chapter.id), notice: 'Sub section was successfully created.' }
        format.json { render :show, status: :created, location: @sub_section }
      else
        format.html { render :new }
        format.json { render json: @sub_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_sections/1
  # PATCH/PUT /sub_sections/1.json
  def update
    @chapter = @sub_section.section.chapter
    respond_to do |format|
      if @sub_section.update(sub_section_params)
        format.html { redirect_to @chapter, notice: 'Sub section was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_section }
      else
        format.html { render :edit }
        format.json { render json: @sub_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_sections/1
  # DELETE /sub_sections/1.json
  def destroy
    @sub_section.destroy
    respond_to do |format|
      format.html { redirect_to @chapter, notice: 'Sub section was successfully destroyed.' }
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

    def set_sub_section
      @sub_section = SubSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_section_params
      params.require(:sub_section).permit(:section_id, :title, :content, :rank, :is_verb)
    end
end
