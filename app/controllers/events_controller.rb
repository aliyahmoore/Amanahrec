class EventsController < ApplicationController
    load_and_authorize_resource
    before_action :set_event, except: [:index, :new, :create]
    
    # GET /events
    def index
        @events = Event.order(start_date: :desc)
    end


    def show
      @can_register = @event.can_register?(current_user)
    end


    # GET /events/new
    def new
      @event = Event.new
    end

    # POST /events
    def create
      @event = Event.new(event_params)

      if @event.save
        Rails.logger.info "Event was successfully created: #{@event.inspect}"
        redirect_to @event, notice: "Event was successfully created."
      else
        Rails.logger.info "Event creation failed: #{@event.errors.full_messages}"
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
      @event = Event.friendly.find(params[:slug])
    end

    # Only allow a list of trusted parameters through
    def event_params
      params.require(:event).permit(
        :title, :description, :start_date, :end_date, :location, :capacity,
        :rsvp_deadline, :childcare, :early_access_for_members, :early_access_days, :general_registration_start, :sponsors, :cost, images: []
      )
    end
end
