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

    hra = @salary.employee.salary * 0.2
    allowance = 3000

    @salary.salary = @salary.employee.salary + hra + allowance
    income_tax = calculate_income_tax(@salary.salary)
    prof_tax = calculate_professional_tax(@salary.salary, @salary.month.month)
    result = calculate_leave(@salary.month.month, @salary.month.year, @salary.employee)

    @salary.leaves = result[:lop_deduction]
    lop = result[:lop]

    total_deduction = income_tax + prof_tax + @salary.leaves

    @salary.save

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Employee_#{@salary.id}", template: 'salaries/salary.html.erb',
             locals: { allowance: allowance, hra: hra, income_tax: income_tax, prof_tax: prof_tax, total_deduction: total_deduction, lop: lop }
      end
    end
  end

  def calculate_salary
    month = params[:month].to_i
    year =  params[:year].to_i

    AttendanceCalculationWorker.perform_async(month, year, params[:emp_ids])

    flash[:notice] = "Attendance calculation job has been queued."
    redirect_to salaries_path
  end

  private

  def calculate_income_tax(salary)
    salary = salary * 12
    case salary
    when 0..250000
      tax = 0
    when 250001..500000
      tax = (salary - 250000) * 0.05
    when 500001..600000
      tax = (salary - 500000) * 0.1
    when 600001..900000
      tax = (salary - 600000) * 0.15
    when 900001..1200000
      tax = (salary - 900000) * 0.2
    when 1200001..1500000
      tax = (salary - 1200000) * 0.25
    else
      tax = (salary - 1500000) * 0.3
    end

    tax = (tax / 12).round
  end


  def calculate_professional_tax(monthly_salary, month)
    annual_salary = monthly_salary * 12

    case month
    when 1..11
      if annual_salary <= 225000
        tax = 0.00
      elsif annual_salary <= 300000
        tax = 125.00
      elsif annual_salary <= 400000
        tax = 150.00
      else
        tax = 175.00
      end
    when 12
      if annual_salary <= 225000
        tax = 0.00
      elsif annual_salary <= 300000
        tax = 125.00
      elsif annual_salary <= 400000
        tax = 174.00
      else
        tax = 212.00
      end
    end

    tax.round
  end


  def calculate_leave(month, year, employee)
    earned_leave_entitlement_per_month = 1
    current_month = Date.new(year.to_i, month.to_i, 1)

    total_earned_leave_availed = 0
    employee.leave_managements.where(leave_type: 'earned_leave')
                              .where("start_date <= ?", current_month.end_of_month)
                              .each do |leave|
                                leave_days = (leave.end_date - leave.start_date + 1).to_i
                                total_earned_leave_availed += leave_days
                              end

    total_earned_leave = [total_earned_leave_availed, (current_month.month - employee.hire_date.month + 1) * earned_leave_entitlement_per_month].min

    lop = [current_month.day - total_earned_leave, 0].max
    lop_deduction = lop * (employee.salary / current_month.end_of_month.day.to_f)

    return { lop: lop, lop_deduction: lop_deduction }
  end
end
