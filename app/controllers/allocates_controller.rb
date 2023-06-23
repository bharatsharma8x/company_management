class AllocatesController < ApplicationController
  load_and_authorize_resource
  before_action :set_allocate, only: %i[show edit update destroy]

  def index
    if current_user.role == 'employee'
      current_user_email = current_user.email
      emp = Employee.find_by(email: current_user_email)
      @allocates = Allocate.where(employee: emp)
    else
      @allocates = Allocate.all
    end
  end

  def show
  end

  def new
    @allocate = Allocate.new
  end

  def create
    @allocate = Allocate.new(allocate_params)

    if @allocate.save
      redirect_to @allocate
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @allocate.update(allocate_params)
      redirect_to @allocate
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @allocate.destroy
      flash[:notice] = 'Allocate deleted successfully.'
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:alert] = 'Cannot delete allocate. It has associated employees and department.'
    end
    redirect_to allocates_path
  end

  private

  def set_allocate
    @allocate = Allocate.find(params[:id])
  end

  def allocate_params
    params.require(:allocate).permit(:allocate_from, :allocate_to, :department_id, :employee_id, :periferal_id)
  end
end