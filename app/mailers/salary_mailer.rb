class SalaryMailer < ApplicationMailer
  def new_salary_email
    @salary = params[:salary]
    @employee_email =@salary.employee.try(:email)
    mail(to: @employee_email, subject: "You got your salary slip!")
  end
end
