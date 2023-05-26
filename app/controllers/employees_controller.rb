class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]

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

  def index
    @employees = Employee.all
  end

  def show
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
      flash[:notice] = "employee deleted successfully."
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:alert] = "Cannot delete employee. It has associated Bank account."
    end
    redirect_to employees_path
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:f_name, :l_name, :dob, :email, :address, :contact_no, :designation, :hire_date, :left_date, :in_hand_salary, :bonus_amount, :ctc, :department_id, :resume, bank_account_attributes: [:bank_name, :account_number, :ifsc_code])
  end

end
