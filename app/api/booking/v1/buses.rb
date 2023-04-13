module Booking
  module V1
    class Buses < Grape::API
      resources :buses do
        desc 'Get all Bus'
        get do
          Bus.all
        end

        desc 'Create a Bus'
        params do
          requires :name, type: String
          requires :typed, type: Integer
          requires :brand, type: String
          requires :capacity, type: Integer
        end
        post do
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
        params do
          requires :id, type: String
        end
        put do
          @bus = Bus.find(params[:id])
          return { 'error': @bus.errors } unless @bus.update(params)

          @bus
        end

        desc 'delete a Bus'
        params do
          requires :id, type: String
        end
        delete do
          Bus.find(params[:id]).destroy
        end
      end
    end
  end
end
