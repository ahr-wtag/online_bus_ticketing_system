module Booking
  module V1
    class Trips < Grape::API
      format :json
      resources :trips do
        desc 'Get all Trips'
        get do
          Trip.all
        end

        desc 'Get Trip by id'
        route_param :id do
          get do
            Trip.find_by(id: params[:id])
          end
        end

        desc 'Create a Trips'
        params do
          requires :ticket_price, type: Integer
          requires :date, type: Date
          requires :time, type: Time
          requires :bus_id, type: Integer
          requires :route_id, type: Integer
        end
        post do
          authenticate!
          return { 'error': 'Authorization Failed' } if admin? == false

          @trip = Trip.new(params)
          return { 'error': @trip.errors } unless @trip.save

          return @trip
        end

        desc 'update a Trips'

        route_param :id do
          put do
            authenticate!
            return { 'error': 'Authorization Failed' } if admin? == false

            @trip = Trip.find(params[:id])
            return { 'error': @trip.errors } unless @trip.update(params)

            @trip
          end
        end

        desc 'delete a Trips'
        route_param :id do
          delete do
            authenticate!
            return { 'error': 'Authorization Failed' } if admin? == false

            Trip.find(params[:id]).destroy
          end
        end
      end
    end
  end
end
