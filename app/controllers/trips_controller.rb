class TripsController < ApplicationController
  before_action :set_trip, only: [ :show ]
    def index
        @trips = Trip.order(start_date: :desc)
    end

    def show
      @can_register = @trip.can_register?(current_user)
    end

    private

    def set_trip
      @trip = Trip.friendly.find(params[:slug])
    end
end
