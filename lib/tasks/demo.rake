namespace :demo do

  desc 'Calclate salary of every employee'
  task calculate_salary: :environment do

    def calculate_salary(employee_id)
      first_of_month = (Date.today - 1.month).beginning_of_month
      last_of_month = (Date.today - 1.month).end_of_month
      emp_salary = Employee.find(employee_id).in_hand_salary
      days_in_month = last_of_month.day
      per_day_salary = emp_salary / days_in_month

      t_present = Attendance.where(employee_id: employee_id, check_in_time: first_of_month..last_of_month, status: 'Present').count
      t_absent = Attendance.where(employee_id: employee_id, check_in_time: first_of_month..last_of_month, status: 'Absent').count
      t_leave = Attendance.where(employee_id: employee_id, check_in_time: first_of_month..last_of_month, status: 'Leave').count

      sat_sun = [0, 6]
      sat_sun_count = ((first_of_month..last_of_month).to_a.select { |k| sat_sun.include?(k.wday) }).count

      t_salary = (t_leave + t_present + sat_sun_count) * per_day_salary

      @nSalary = Salary.new(employee_id: employee_id, month: Time.now - 1.month, total_days: days_in_month, present_days: t_present, leaves: t_leave, absents: t_absent, salary: t_salary)
      if @nSalary.save
        salary_detail = SalaryMailer.with(salary: @nSalary).new_salary_email.deliver_now
        puts "#{salary_detail}"
      end


    end

    employee_ids = Employee.all.ids
    employee_ids.each { |employee_id| calculate_salary(employee_id) }
  end

end
