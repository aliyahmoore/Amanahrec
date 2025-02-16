class EventsController < ApplicationController
  before_action :set_event, only: [ :show ]
    def index
        @events = Event.order(start_date: :desc)
    end

    def show
      @can_register = @event.can_register?(current_user)
    end

    private

    def set_event
      @event = Event.friendly.find(params[:slug])
    end
end
