require 'numbers_and_words'

class SalariesController < ApplicationController
  load_and_authorize_resource
  def index
    if current_user.role == 'employee'
      current_user_email = current_user.email
      emp = Employee.find_by(email: current_user_email)
      @salaries = Salary.where(employee: emp)
    else
      @salaries = Salary.all
    end
  end

  def show
    @salary = Salary.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Employee_#{@salary.id}", template: 'salaries/salary.html.erb', distortion: "attachment"   # Excluding ".pdf" extension.
      end
    end
  end

  def calculate_salary
    month = params[:month].to_i
    year =  params[:year].to_i

    # Queue the salary calculation job
    AttendanceCalculationWorker.perform_async(month, year, params[:emp_ids])

    flash[:notice] = "Attendance calculation job has been queued."
    redirect_to salaries_path
  end
end
