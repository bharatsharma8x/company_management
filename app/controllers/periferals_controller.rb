class PeriferalsController < ApplicationController
  def index
    @periferals = Periferal.all
  end

  def show
    @periferal = Periferal.find(params[:id])
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
    @periferal = Periferal.find(params[:id])
  end

  def update
    @periferal = Periferal.find(params[:id])

    if @periferal.update(periferal_params)
      redirect_to @periferal
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @periferal = Periferal.find(params[:id])
    @periferal.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def periferal_params
      params.require(:periferal).permit(:name, :description, :quantity, :assign_to, :supplier_id, :manufacture_id, :delivery_date, :order_date, :warranty_start_date, :warranty_duration)
    end

end
