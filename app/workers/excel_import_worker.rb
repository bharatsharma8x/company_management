require 'roo'

class ExcelImportWorker
  include Sidekiq::Worker

  def perform(file_path)
    spreadsheet = Roo::Spreadsheet.open(file_path)
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      # Check if the employee exists
      employee = find_employee(row)
      unless employee
        puts "Employee #{row['Name of Employee']} not found. Attendance record not created."
        next
      end

      # Update employee's salary if necessary
      if row['Salary'].to_i > employee.salary.to_i
        employee.update(salary: row['Salary'])
      end

      update_salary(row, employee)

      create_attendance(row, employee)

    end

  end

  private

  def find_employee(row)
    f_name, l_name = row['Name of Employee'].split(' ')
    Employee.find_by(f_name: f_name, l_name: l_name)
  end

  def update_salary(row, employee)
    date_column = row.keys.find { |key| key.is_a?(Date) }

    # Extract the month from the date column
    if date_column
      month = date_column.beginning_of_month
    else
      # If no date column is found, use the current month
      month = Date.today.beginning_of_month
    end

    salary_record = Salary.find_or_initialize_by(employee_id: employee.id, month: month)

    # Update the fields
    salary_record.total_days = (month - 1).day
    salary_record.present_days = row['Total Present']
    salary_record.leaves = row['Leave adjusted']
    salary_record.absents = row['absent']
    salary_record.salary = row['Final Pay out']

    # Save the record
    salary_record.save
  end

  def map_status(status)
    case status.upcase
    when "P"
      "P"
    when "A"
      "A"
    when "L"
      "L"
    when "OFF"
      "Off"
    else
      "Unknown"
    end
  end

  def create_attendance(row, employee)
    year = row.keys.find { |key| key.is_a?(Date) }.year
    month = row.keys.find { |key| key.is_a?(Date) }.month
    days_in_month = Date.new(year, month, -1).day

    relevant_keys = row.keys.select { |key| key.is_a?(Date) && key.month == month }
    relevant_keys.each do |date_key|
      status = row[date_key]
      status = status.to_s.strip

      next if status.blank?

      date = date_key
      status_value = map_status(status)

      attendance = Attendance.new(
        employee_id: employee.id,
        status: status_value,
        check_in_time: Time.zone.parse("#{date} 10:00:00"),
        check_out_time: Time.zone.parse("#{date} 19:00:00")
      )

      attendance.save
    end
  end
end
