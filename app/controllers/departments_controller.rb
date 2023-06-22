class DepartmentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_department, only: %i[show edit update destroy]
  include Pagy::Backend

  def index
    @pagy, @departments = pagy(Department.all)
    if params[:order_by].present?
      order_by = params[:order_by]
      order = params[:order] || 'asc'
      if order == 'asc'
        @departments = @departments.order(order_by)
      elsif order == 'desc'
        @departments = @departments.order(order_by => :desc)
      end
    end
  end

  def show
    @employees = @department.employees
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
    begin
      @department.destroy
      flash[:notice] = "#{@department.department_name} department deleted successfully."
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:alert] = 'Cannot delete department. It has associated employees.'
    end

    redirect_to departments_path
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:department_name)
  end
end