module Booking
  module V1
    class Routes < Grape::API
      format :json
      resources :routes do
        desc 'Get all route'
        get do
          Route.all
        end

        desc 'Get route by id'
        route_param :id do
          get do
            Route.find_by(id: params[:id])
          end
        end

        desc 'Create a route'
        params do
          requires :origin, type: String
          requires :destination, type: String
        end
        post do
          authenticate!
          return { 'error': 'Authorization Failed' } if admin? == false

          @route = Route.new(params)
          return { 'error': @route.errors } unless @route.save

          return @route
        end

        desc 'update a route'
        route_param :id do
          put do
            authenticate!
            return { 'error': 'Authorization Failed' } if admin? == false

            @route = Route.find(params[:id])
            return { 'error': @route.errors } unless @route.update(params)

            @route
          end
        end

        desc 'delete a route'

        route_param :id do
          delete do
            authenticate!
            return { 'error': 'Authorization Failed' } if admin? == false

            Route.find(params[:id]).destroy
          end
        end
      end
    end
  end
end
