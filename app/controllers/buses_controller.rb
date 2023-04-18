class BusesController < ApplicationController
  before_action :find_bus_by_id, only: %i[edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @buses = Bus.all.order('id ASC')
  end

  def new
    @bus = Bus.new
  end

  def create
    @bus = Bus.new(bus_params)
    if @bus.save
      redirect_to action: 'index', status: :created
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @bus.update(bus_params)
      redirect_to action: 'index', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bus.destroy
    redirect_to action: 'index', status: :see_other
  end

  private

  def bus_params
    params.require(:bus).permit(:name, :typed, :brand, :capacity)
  end

  def find_bus_by_id
    @bus = Bus.find(params[:id])
  end
end
