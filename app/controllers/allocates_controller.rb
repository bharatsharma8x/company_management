class AllocatesController < ApplicationController
  before_action :set_allocate, only: %i[ show edit update destroy]

  def index
    @allocates = Allocate.all
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
      redirect_to "/allocates", status: :see_other
    rescue StandardError => e
      puts e
    end
  end

  private
  def set_allocate
    @allocate = Allocate.find(params[:id])
  end

  def allocate_params
    params.require(:allocate).permit(:allocate_from, :allocate_to, :department_id, :employee_id, :periferal_id)
  end

end
