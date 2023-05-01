module Booking
  module V1
    class Booking < Grape::API
      format :json
      resources :booking do
        desc 'Get all Trips'
        params do
          requires :origin, type: String
          requires :destination, type: String
          requires :date, type: String
        end
        get :trips do
          @trips = Trip.where(date: params[:date].presence,
                              route: Route.find_by(origin: params[:origin].presence,
                                                   destination: params[:destination].presence))
        end

        get 'Get all seats'
        route_param :id do
          get do
            @trip = Trip.find_by(id: params[:id])
            @bus = Bus.find_by(id: @trip.bus.id)
            @seats = @bus.seats.order(id: :asc)
          end
        end

        desc 'book seats'
        post do
          authenticate!
          @seats = params[:seats].split(',')

          @trip = Trip.find_by(id: params[:trip_id])
          @payment = Payment.create
          @total = @seats.size * @trip.ticket_price
          @user = current_user

          @ticket = Ticket.new(total_fare: @total, user: current_user, payment: @payment, trip: @trip, bus: @trip.bus)

          for i in @seats
            next unless @trip.bus.seats.find_by(id: i).booked == true

            return { 'error': 'Seat is already booked by others' }

          end
          return { 'error': 'Something went wrong' } unless @ticket.save

          for i in @seats
            @trip.bus.seats.find_by(id: i).update(booked: true, ticket: @ticket)
          end
          return { 'message': 'Succesfully Booked' }
        end
      end
    end
  end
end
