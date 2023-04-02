class TicketsController < ApplicationController
  before_action :find_dependency, only: %i[index]
  before_action :authenticate_user!
  def index
    @origins = Route.select('DISTINCT ON (origin) *')
    @destinations = @destination || []
    @trips = @trip || []
  end

  def seatPlan
    @trip = Trip.find_by(id: params[:id])
    @bus = Bus.find_by(id: @trip.bus.id)
    @seats = @bus.seats.order(id: :asc)
    puts @seats.ids
  end

  def confirm_payment
    @seats = session[:seats]
    @trip = Trip.find_by(id: session[:trip])
    @total = @seats.size * @trip.ticket_price
    @ticket = Ticket.new(total_fare: @total, user: current_user, payment_id: 1, trip: @trip, bus: @trip.bus)

    for i in @seats
        if @trip.bus.seats.find_by(id:i).booked == true
            flash[:alert] = "Booking Failed";
            return redirect_to action: 'index';
            
        end
    end


    if @ticket.save
      for i in @seats
        @trip.bus.seats.find_by(id:i).update(booked: true)
      end
      flash[:notice] = "Succesfully Booked"
      redirect_to action: 'index';
    else
    
        flash[:alert] = "Booking Failed"
        redirect_to action: 'index';
    end
  end

  def process_payment
    @seats = session[:seats]
    @trip = Trip.find_by(id: session[:trip])
    @total = @trip.ticket_price * session[:seats].size
  end

  def payment
    @seats = []
    params.each do |key, value|
      @seats.push(value) if key == value
    end
    @seat_session = session[:seats] || []
    session[:seats] = @seats
    session[:trip] = params[:trip_id]
    redirect_to process_payment_path, status: :see_other
  end

  private

  def find_dependency
    @origin = Route.find_by(id: params[:origin].presence)
    @destination = Route.where(origin: params[:origin].presence)
    @trip = Trip.where(date: params[:date].presence,
                       route: Route.find_by(origin: params[:origin].presence,
                                            destination: params[:destination].presence))
  end
end
