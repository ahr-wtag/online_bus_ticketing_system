module Booking
  module V1
    class Routes < Grape::API
      format :json
      resources :routes do
        desc 'Get all route'
        get do
          Route.all
        end

        desc 'Create a route'
        params do
          requires :origin, type: String
          requires :destination, type: String
        end
        post do
          @route = Route.new(params)
          return { 'error': @route.errors } unless @route.save

          return @route
        end

        desc 'update a route'
        params do
          requires :id, type: String
        end
        put do
          @route = Route.find(params[:id])
          return { 'error': @route.errors } unless @route.update(params)

          @route
        end

        desc 'delete a route'
        params do
          requires :id, type: String
        end
        delete do
          Route.find(params[:id]).destroy
        end
      end
    end
  end
end
