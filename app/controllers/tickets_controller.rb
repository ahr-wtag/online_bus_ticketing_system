class TicketsController < ApplicationController
  before_action :find_dependency, only: %i[index]
  before_action :authenticate_user!, only: %i[process_payment confirm_payment]
  def index
    @origins = Route.select('DISTINCT ON (origin) *')
    @destinations = @destination || []
    @trips = @trip || []
  end

  def seat_plan
    @trip = Trip.find_by(id: params[:id])
    @bus = Bus.find_by(id: @trip.bus.id)
    @seats = Seat.where(trip: @trip, bus: @bus).order(id: :asc)
  end

  def confirm_payment
    @seats = session[:seats]
    @trip = Trip.find_by(id: session[:trip])
    @payment = Payment.create
    @total = @seats.size * @trip.ticket_price
    @ticket = Ticket.new(total_fare: @total, user: current_user, payment: @payment, trip: @trip, bus: @trip.bus)

    for i in @seats
      next unless @trip.bus.seats.find_by(id: i).booked == true

      flash[:alert] = 'Booking Failed'
      return redirect_to action: 'index', status: :see_other

    end
    if @ticket.save
      for i in @seats
        @trip.bus.seats.find_by(id: i).update(booked: true, ticket: @ticket)
      end
      flash[:notice] = 'Succesfully Booked'
      redirect_to action: 'index', status: :see_other
    else

      flash[:alert] = 'Booking Failed'
      redirect_to action: 'index', status: :see_other
    end
  end

  def process_payment
    @seats = session[:seats]
    @trip = Trip.find_by(id: session[:trip])
    @total = @trip.ticket_price * session[:seats].size
    return unless @total == 0

    flash[:alert] = 'Select atleast 1 seat'
    redirect_to seat_plan_path(@trip), status: :see_other
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
