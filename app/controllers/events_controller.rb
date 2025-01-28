class EventsController < ApplicationController
    before_action :set_event, only: %i[show edit update destroy]

    # GET /events
    def index
        # everyone can see all events
        @events = Event.all
    end

    # GET /events/:id
    def show
      @can_rsvp = if current_user&.member?
                    # Members can RSVP during early access or general registration
                    @event.early_access_for_members && Time.current >= @event.early_access_days ||
                      Time.current >= @event.general_registration_start
                  else
                    # Non-members can only RSVP during the general registration period
                    Time.current >= @event.general_registration_start
                  end
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
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def event_params
      params.require(:event).permit(
        :title, :description, :start_date, :end_date, :location,
        :rsvp_deadline, :childcare,:early_access_for_members,:early_access_days,:general_registration_start,:sponsors, :cost, images: []
      )
    end
end
