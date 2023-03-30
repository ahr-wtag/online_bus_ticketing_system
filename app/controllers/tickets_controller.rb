class TicketsController < ApplicationController
    before_action :find_dependency , only: %i[index]
    def index
        @origins = Route.select('DISTINCT ON (origin) *')
        @destinations = @destination || []
        @trips = @trip || []
    end

    def seatPlan
       @trip = Trip.find_by(id:params[:id]);
       @bus = Bus.find_by(id:@trip.bus.id);
    end

    def confirm_payment
        
    end
    def payment
        redirect_to action: 'confirm_payment', status: :see_other
    end

    private 
    def find_dependency
        @origin = Route.find_by(id:params[:origin].presence);
        @destination = Route.where(origin: params[:origin].presence)
        @trip = Trip.where(date:params[:date].presence,route:Route.find_by(origin: params[:origin].presence,destination:params[:destination].presence));
    end
end
