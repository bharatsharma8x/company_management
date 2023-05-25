class PeriferalsController < ApplicationController
  before_action :set_periferal, only: %i[ show edit update destroy ]

  def index
      @periferals = Periferal.all
  end

  def show
  end

  def new
    @periferal = Periferal.new
  end

  def create
    @periferal = Periferal.new(periferal_params)

    if @periferal.save
      redirect_to @periferal
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @periferal.update(periferal_params)
      redirect_to @periferal
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @periferal.destroy
      flash[:notice] = "periferal deleted successfully."
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:alert] = "Cannot delete periferal"
    end
    redirect_to periferals_path
  end

  private
  def set_periferal
    @periferal = Periferal.find(params[:id])
  end

  def periferal_params
    params.require(:periferal).permit(:name, :description, :category, :purchase_date, :purchase_cost, :condition, :warranty_start_date, :warranty_duration_months, :bill)
  end

end
