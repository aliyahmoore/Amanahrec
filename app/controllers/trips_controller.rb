class TripsController < ApplicationController
  before_action :set_trip, only: [ :show ]
    def index
      @current_trips = Trip.where("start_date >= ?", Date.today).order(start_date: :asc)
      @past_trips = Trip.where("start_date < ?", Date.today).order(start_date: :desc)
    end

    def show
      @can_register = @trip.can_register?(current_user)
    end

    private

    def set_trip
      @trip = Trip.friendly.find(params[:slug])
    end
end
