class TripsController < ApplicationController
    before_action :find_trip_by_id, only: [:edit,:update,:destroy ]
    
    def index
        @trips = Trip.all.order("id ASC")
    end

    def new
        @trip = Trip.new
    end

    def create
        @trip = Trip.new(trip_params)
        if @trip.save
            redirect_to action: 'index', status: :see_other
        else
          render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @trip.update(trip_params)
            redirect_to action: 'index', status: :see_other
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @trip.destroy
        redirect_to action: 'index', status: :see_other
    end


    
    private
    
    def trip_params
        params.require(:trip).permit(:ticket_price,:date,:time,:bus_id,:route_id);
    end

    def find_trip_by_id
        @trip = Trip.find(params[:id]);
    end

end