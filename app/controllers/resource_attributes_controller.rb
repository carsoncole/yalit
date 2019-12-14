class ResourceAttributesController < ApplicationController
  before_action :set_section
  before_action :set_resource_attribute, only: [:show, :edit, :update, :destroy]

  def index
    @resource_attributes = @section.resource_attributes
  end

  def show
  end

  def edit
  end

  def update
    if @resource_attribute.update(resource_attribute_params)
      redirect_to chapter_path(@section.chapter), notice: "resource attribute was successfully updated."
    else
      render :edit
    end
  end

  def new
    @resource_attribute = @section.resource_attributes.new
  end

  def create
    @resource_attribute = @section.resource_attributes.build(resource_attribute_params)

    if @resource_attribute.save
      redirect_to chapter_path(@section.chapter), notice: "resource attribute was successfully created."
    else
      render :new
    end
  end

  def destroy
    @resource_attribute.destroy
    redirect_to section_resource_attributes_path(@section)
  end

  private

  def set_section
    @section = Section.find(params[:section_id]) if params[:section_id]
  end

  def set_resource_attribute
    @resource_attribute = @section.resource_attributes.find(params[:id])
  end

  def resource_attribute_params
    params.require(:resource_attribute).permit(:key, :field_type, :description, :is_required)
  end
end
