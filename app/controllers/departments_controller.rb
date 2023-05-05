class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show edit update destroy]

  def index
    @departments = Department.all
  end

  def show
    # @department = Department.find(params[:id])
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
    # @department = Department.find(params[:id])
  end

  def update
    # @department = Department.find(params[:id])

    if @department.update(department_params)
      redirect_to @department
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @department = Department.find(params[:id])
    @department.destroy

    redirect_to "/departments", status: :see_other
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:dep_name, :num_of_employee)
  end

end
