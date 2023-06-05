class SalariesController < ApplicationController
  def index
    @salaries = Salary.all
  end
end
