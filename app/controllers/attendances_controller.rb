class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]

  def index 
    @employees = Employee.all
    @selected_employee_id = params[:employee_id]

    @attendances = Attendance.all

    if @selected_employee_id.present?
      @attendances = @attendances.where(employee_id: @selected_employee_id)
    end

    # Add sorting logic based on your requirements
    @attendances = @attendances.order(check_in_time: :desc)

  end

  def show
  end

  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.new(attendance_params)

    if @attendance.save
      redirect_to attendances_path, notice: 'Attendance was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @attendance.update(attendance_params)
      redirect_to @attendance, notice: 'Attendance was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @attendance.destroy
    redirect_to attendances_url, notice: 'Attendance was successfully destroyed.'
  end

  private

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:employee_id, :status, :check_in_time, :check_out_time, :hours_worked)
  end
end
