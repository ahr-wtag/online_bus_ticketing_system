module Booking
  module V1
    class Trips < Grape::API
      format :json
      resources :trips do
        desc 'Get all route'
        get do
          Trip.all
        end

        desc 'Create a route'
        params do
          requires :ticket_price, type: Integer
          requires :date, type: Date
          requires :time, type: Time
          requires :bus_id, type: Integer
          requires :route_id, type: Integer
        end
        post do
          @trip = Trip.new(params)
          return { 'error': @trip.errors } unless @trip.save

          return @trip
        end

        desc 'update a route'
        params do
          requires :id, type: String
        end
        put do
          @trip = Trip.find(params[:id])
          return { 'error': @trip.errors } unless @trip.update(params)

          @trip
        end

        desc 'delete a route'
        params do
          requires :id, type: String
        end
        delete do
          Trip.find(params[:id]).destroy
        end
      end
    end
  end
end
