module Booking
  module V1
    class Buses < Grape::API
      resources :buses do
        desc 'Get all Bus'
        get do
          Bus.all
        end

        desc 'Get Bus by id'
        route_param :id do
          get do
            Bus.find_by(id: params[:id])
          end
        end

        desc 'Create a Bus'
        params do
          requires :name, type: String
          requires :typed, type: Integer
          requires :brand, type: String
          requires :capacity, type: Integer
        end
        post do
          authenticate!
          return { 'error': 'Authorization Failed' } if admin? == false

          @bus = Bus.new(params)
          return { 'error': @bus.errors } unless @bus.save

          count = @bus.capacity
          for char in [*'A'..'Z'] do
            Seat.create(number: char + '1', booked: false, bus: @bus)
            count -= 1
            break if count == 0

            Seat.create(number: char + '2', booked: false, bus: @bus)
            count -= 1
            break if count == 0
          end
          return @bus
        end

        desc 'update a Bus'

        route_param :id do
          put do
            authenticate!
            return { 'error': 'Authorization Failed' } if admin? == false

            @bus = Bus.find(params[:id])
            return { 'error': @bus.errors } unless @bus.update(params)

            @bus
          end
        end

        desc 'delete a Bus'
        route_param :id do
          delete do
            authenticate!
            return { 'error': 'Authorization Failed' } if admin? == false

            Bus.find(params[:id]).destroy
          end
        end
      end
    end
  end
end
