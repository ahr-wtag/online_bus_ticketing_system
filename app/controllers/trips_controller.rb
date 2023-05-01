class TripsController < ApplicationController
  before_action :find_trip_by_id, only: %i[edit show update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @trips = Trip.all.order('id ASC')
  end

  def new
    @trip = Trip.new
  end

  def show
    @tickets = Ticket.where(trip: @trip)
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      _count = @trip.bus.capacity
      for char in [*'A'..'Z'] do
        Seat.create(number: char + '1', booked: false, bus: @trip.bus, trip: @trip)
        _count -= 1
        break if _count == 0

        Seat.create(number: char + '2', booked: false, bus: @trip.bus, trip: @trip)
        _count -= 1
        break if _count == 0
      end

      redirect_to action: 'index', status: :created
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @trip.bus.nil? || @trip.bus.id != trip_params[:bus_id]
      @tickets = Seat.where(trip: @trip, bus: @trip.bus, booked: true)
      tp = trip_params
      if @tickets.size > 0
        flash[:alert] = 'some Seat is already sold, cant update bus now'
        if @trip.bus.nil?
          flash[:alert] = 'Cant Update,Contact with DB Admin'
          return render :edit, status: :unprocessable_entity
        end
        tp[:bus_id] = @trip.bus.id
      else
        Seat.where(trip: @trip, bus: @trip.bus).destroy_all

        @bus = Bus.find(trip_params[:bus_id])
        _count = @bus.capacity

        for char in [*'A'..'Z'] do
          Seat.create!(number: char + '1', booked: false, bus: @bus, trip: @trip)
          _count -= 1
          break if _count == 0

          Seat.create!(number: char + '2', booked: false, bus: @bus, trip: @trip)
          _count -= 1
          break if _count == 0
        end

      end
    end

    if @trip.update!(tp)
      redirect_to action: 'index', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip.destroy
    redirect_to action: 'index', status: :see_other
  end

  private

  def trip_params
    params.require(:trip).permit(:ticket_price, :total_booked, :date, :time, :bus_id, :route_id)
  end

  def find_trip_by_id
    @trip = Trip.find(params[:id])
  end
end
