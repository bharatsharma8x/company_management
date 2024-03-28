require 'fileutils'
class AttendancesController < ApplicationController
  load_and_authorize_resource

  before_action :set_attendance, only: %i[show edit update destroy]
  include Pagy::Backend

  def index
    if params[:employee_id].present? && params[:start_][:month].present?
      employee_id = params[:employee_id]
      month = Date.strptime(params[:start_][:month], '%m')
      start_date = month.beginning_of_month
      end_date = month.end_of_month
      @pagy, @attendances = pagy(Attendance.where(employee_id: employee_id, check_in_time: start_date..end_date), items: 5)
    else

      if current_user.role == 'employee'
        current_user_email = current_user.email
        emp = Employee.find_by(email: current_user_email)
        @pagy, @attendances = pagy(Attendance.where(employee: emp), items: 5)
      else
        @pagy, @attendances = pagy(Attendance.all, items: 5)
      end

    end
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

  def import
    uploaded_file = params[:attendance][:file]

    if uploaded_file.present?
      filename = SecureRandom.uuid + ".xlsx"  # Generate unique filename
      directory = Rails.root.join("public", "uploads")
      FileUtils.mkdir_p(directory) unless File.directory?(directory)  # Create directory if it doesn't exist
      filepath = File.join(directory, filename)
      File.open(filepath, 'wb') do |file|
        file.write(uploaded_file.read)
      end
      # Schedule the worker with the persistent file path
      ExcelImportWorker.perform_async(filepath.to_s)

      flash[:notice] = "Excel import job has been queued."
      redirect_to attendances_path, notice: "Data import job has been queued."
    else
      flash[:error] = "Please select a file to upload."
      render :new
    end

    sleep(5)
    # Delete uploaded file after enqueuing worker
    File.delete(filepath) if File.exist?(filepath)
  end

  private

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:employee_id, :status, :check_in_time, :check_out_time, :hours_worked)
  end
end
