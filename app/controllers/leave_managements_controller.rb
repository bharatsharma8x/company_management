class LeaveManagementsController < ApplicationController
  before_action :set_employee, except: [:pending_leaves]
  before_action :set_leave_management, only: [:show, :edit, :update, :destroy, :approve, :reject, :update_reason]

  def index
    @leave_managements = @employee.leave_managements
  end

  def show
  end

  def new
    @leave_management = @employee.leave_managements.new
  end

  def edit
  end

  def create
    @leave_management = @employee.leave_managements.new(leave_management_params)

    if @leave_management.save
      redirect_to employee_leave_management_path(@employee, @leave_management), notice: 'Leave management was successfully created.'
    else
      render :new
    end
  end

  def update
    if @leave_management.update(leave_management_params)
      redirect_to employee_leave_management_path(@employee, @leave_management), notice: 'Leave management was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @leave_management.destroy
    redirect_to employee_leave_managements_path(@employee), notice: 'Leave management was successfully destroyed.'
  end

  def pending_leaves
    @pending_leaves = LeaveManagement.pending
  end

  def approve
    @leave_management.update(status: :approved)
    redirect_to pending_leaves_leave_managements_path, notice: 'Leave request approved successfully.'
  end

  def reject
    @leave_management.update(status: :rejected)
    redirect_to pending_leaves_leave_managements_path, notice: 'Leave request rejected successfully.'
  end

  private
  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def set_leave_management
    @leave_management = @employee.leave_managements.find(params[:id])
  end

  def leave_management_params
    params.require(:leave_management).permit(:leave_type, :start_date, :end_date, :status)
  end
end
