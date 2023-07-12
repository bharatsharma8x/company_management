class SalaryMailer < ApplicationMailer
  def new_salary_email
    @salary = params[:salary]

    attachments["Salary_#{@salary.id}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: 'salary', template: 'salaries/salary.html.erb'), { hash_with_wickedpdf_options: {} })

    @employee_email = @salary.employee.try(:email)
    mail(to: @employee_email, subject: 'You got your salary slip!')
  end
end
