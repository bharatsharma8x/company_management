class SalariesController < ApplicationController
  load_and_authorize_resource
  def index
    @salaries = Salary.all
  end

  def show
    @salary = Salary.find(params[:id])
    
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Employee_#{@salary.id}", template: "salaries/salary.html.erb"   # Excluding ".pdf" extension.
      end
    end
  end
end
