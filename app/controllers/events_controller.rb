class EventsController < ApplicationController
    before_action :set_event, only: %i[show edit update destroy]

    # GET /events
    def index
      @events = Event.all
    end

    # GET /events/:id
    def show
      # @event is already set by before_action
    end

    # GET /events/new
    def new
      @event = Event.new
    end

    # POST /events
    def create
      @event = Event.new(event_params)

      if @event.save
        redirect_to @event, notice: "Event was successfully created."
      else
        render :new
      end
    end

    # GET /events/:id/edit
    def edit
      @event = Event.find(params[:id])
    end
    

    # PATCH/PUT /events/:id
    def update
      if @event.update(event_params)
        redirect_to @event, notice: "Event was successfully updated."
      else
        render :edit
      end
    end

    # DELETE /events/:id
    def destroy
        @event.destroy
        respond_to do |format|
          format.html { redirect_to events_url, notice: "Event was successfully deleted." }
          format.json { head :no_content }
        end
      end

    private

    # Set event for show, edit, update, and destroy actions
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def event_params
      params.require(:event).permit(
        :title, :description, :time, :date, :end_date, :location,
        :rsvp_deadline, :childcare, :sponsors, :cost
      )
    end
end
