class ParametersController < ApplicationController
  before_action :set_request_method
  before_action :set_parameter, only: [:show, :edit, :update, :destroy]

  def index
    @parameters = @request_method.parameters
  end

  def show
  end

  def edit
  end

  def update
    if @parameter.update(parameter_params)
      redirect_to request_method_parameters_path(@request_method), notice: "param was successfully updated."
    else
      render :edit
    end
  end

  def new
    @parameter = @request_method.parameters.new
  end

  def create
    @parameter = @request_method.parameters.build(parameter_params)

    if @parameter.save
      redirect_to request_method_parameters_path(@request_method), notice: "Parameter was successfully created."
    else
      render :new
    end
  end

  def destroy
    @parameter.destroy
    redirect_to request_method_parameters_path(@request_method)
  end

  private

  def set_request_method
    @request_method = RequestMethod.find(params[:request_method_id]) if params[:request_method_id]
  end

  def set_parameter
    @parameter = @request_method.parameters.find(params[:id])
  end

  def parameter_params
    params.require(:parameter).permit(:key, :value)
  end
end
