class ErrorCodesController < ApplicationController
  before_action :require_login
  before_action :set_section

  def index
    @error_codes = @section.error_codes.order(:custom_status_code, :http_status_code)
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
    @error_code = @section.error_codes.new
  end

  def create
    @error_code = @section.error_codes.build(error_code_params)
    if @error_code.save
      redirect_to chapter_path(@section.chapter), notice: "error_code was successfully created."
    else
      render :new
    end
  end

  def destroy
  end

  private

  def set_section
    @section = Section.find(params[:section_id])
  end

  def error_code_params
    params.require(:error_code).permit(:http_status_code, :custom_status_code, :description, :title)
  end
end
