class ErrorCodesController < ApplicationController
  before_action :require_login
  before_action :set_section
  before_action :set_error_code, except: [:new, :create]

  def index
    @error_codes = @section.error_codes.order(:custom_status_code, :http_status_code)
  end

  def show
  end

  def edit
  end

  def update
    if @error_code.update(error_code_params)
      redirect_to chapter_path(@section.chapter), notice: "Error code was successfully updated."
    else
      render :edit
    end
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
    @error_code.destroy
    redirect_to chapter_path(@section.chapter)
  end

  private

  def set_error_code
    @error_code = ErrorCode.find(params[:id])
  end

  def set_section
    @section = Section.find(params[:section_id])
  end

  def error_code_params
    params.require(:error_code).permit(:http_status_code, :custom_status_code, :message, :title)
  end
end
