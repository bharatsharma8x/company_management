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
        render pdf: "Employee_#{@salary.id}", template: 'salaries/salary.html.erb'   # Excluding ".pdf" extension.
      end
    end
  end
end
