class RoutesController < ApplicationController
  before_action :find_route_by_id, only: %i[edit update destroy]

  def index
    @routes = Route.all.order('id ASC')
  end

  def new
    @route = Route.new
  end

  def create
    @route = Route.new(route_params)
    if @route.save
      redirect_to action: 'index', status: :created
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @route.update(route_params)
      redirect_to action: 'index', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @route.destroy
    redirect_to action: 'index', status: :see_other
  end

  private

  def route_params
    params.require(:route).permit(:origin, :destination)
  end

  def find_route_by_id
    @route = Route.find(params[:id])
  end
end
