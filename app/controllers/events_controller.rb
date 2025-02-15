class EventsController < ApplicationController
    def index
        @events = Event.order(start_date: :desc)
    end
    def show
      @can_register = @event.can_register?(current_user)
    end
end
