class TicketsController < ApplicationController
    before_action :find_dependency , only: %i[index]
    def index
        @origins = Route.select('DISTINCT ON (origin) *')
        @destinations = @destination || []
        @times = @time != []? @time.select(:time).group(:time) : []
        @buses = @bus || []
    end

    private 
    def find_dependency
        @origin = Route.find_by(id:params[:origin].presence);
        @destination = Route.where(origin: params[:origin].presence)
        @time = Route.where(origin:params[:origin].presence,destination:params[:destination].presence)[0]
        @bus = @time.nil? == true ? [] : @time.trips.where(time:params[:time].presence)   
        @time = @time.nil? == true ? [] : @time.trips.where(date:params[:date].presence)
    end
end
