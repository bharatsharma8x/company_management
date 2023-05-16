class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show edit update destroy]

  def index
    @departments = Department.all
    # byebug
    # @department.find_by_name("hr")
  end

  def show
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)

    if @department.save
      redirect_to @department
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @department.update(department_params)
      redirect_to @department
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @department.destroy
    redirect_to "/departments", status: :see_other
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:department_name)
  end

end
