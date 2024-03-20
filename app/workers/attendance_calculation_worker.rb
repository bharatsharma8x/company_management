class AttendanceCalculationWorker
  include Sidekiq::Worker
  queue_as :default

  def perform(month, year, emp_ids)
    # Calculating previous month's start and end dates
    start_date = Date.new(year, month, 1).beginning_of_month
    end_date = Date.new(year, month, 1).end_of_month

    employees = emp_ids.present? ? Employee.where(id: emp_ids) : Employee.all

    employees.each do |employee|
      # Fetch or create the salary record for the employee and month
      salary = Salary.find_or_create_by(employee_id: employee.id, month: Date.new(year, month, 1))

      last_month_attendance = employee.attendance.where(check_in_time: start_date..end_date)
      total_days = end_date.day
      present_days = last_month_attendance.where(status: 'P').count
      absent_days = last_month_attendance.where(status: 'A').count
      leaves = last_month_attendance.where(status: 'L').count
      salary_amount = employee.salary.present? ? (employee.salary / total_days.to_f) * present_days : 0

      # Update the salary record attributes
      salary.update(total_days: total_days, present_days: present_days, absents: absent_days, leaves: leaves, salary: salary_amount)
    end

    # Log or notify completion of the job
    Rails.logger.info "Salary calculation job completed for month: #{month}, year: #{year}"
  end
end
