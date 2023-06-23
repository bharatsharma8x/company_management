class EmployeesController < ApplicationController
  load_and_authorize_resource

  before_action :set_employee, only: %i[show edit update destroy]

  def filter_by_department
    if params[:department_id].present?
      @set_employees = Employee.where(department_id: params[:department_id])
    else
      @set_employees = []
    end

    respond_to do |format|
      format.json { render json: @set_employees }
    end
  end

  def sort
    @employees = Employee.order(f_name: sort_direction)
    respond_to do |format|
      format.js
    end
  end

  def index
    if current_user.role == 'employee'
      current_user_email = current_user.email
      @employees = Employee.find_by(email: current_user_email)
    else
      if params[:search]
        @employees = Employee.search_by_name(params[:search])
      else
        @employees = Employee.all
      end
    end

    if params[:order_by].present?
      order_by = params[:order_by]
      order = params[:order] || 'asc'
      if order == 'asc'
        @employees = @employees.order(order_by)
      elsif order == 'desc'
        @employees = @employees.order(order_by => :desc)
      end
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Employees#{@employees.count}", template: 'employees/index.html.erb'   # Excluding ".pdf" extension.
      end
    end

  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Employee_#{@employee.id}", template: 'employees/emp.html.erb'   # Excluding ".pdf" extension.
      end
    end
  end

  def new
    @employee = Employee.new
    @employee.build_bank_account
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @employee.destroy
      flash[:notice] = 'employee deleted successfully.'
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:alert] = 'Cannot delete employee. It has associated Bank account.'
    end
    redirect_to employees_path
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:f_name, :l_name, :dob, :email, :address, :contact_no, :designation, :hire_date, :left_date, :in_hand_salary, :bonus_amount, :ctc, :department_id, :resume, bank_account_attributes: %i[bank_name account_number ifsc_code])
  end

  def sort_direction
    session[:sort_direction] = session[:sort_direction] == 'asc' ? 'desc' : 'asc'
  end

end
