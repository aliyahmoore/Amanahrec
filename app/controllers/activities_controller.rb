class ActivitiesController < ApplicationController
    before_action :set_activity, only: [ :show, :edit, :update, :destroy ]


    def index
        @activities = Activity.all
    end


    def show
        @activity
    end


    def new
        @activity = Activity.new
    end


    def create
        @activity = Activity.new(activity_params)


        if @activity.save
            redirect_to @activity, notice: "Activity was successfully created"
        else
            render :new
        end
    end


    def edit
        @activity
    end


    def update
        if @activity.update(activity_params)
          redirect_to @activity, notice: "Activity was successfully updated."
        else
          render :edit
        end
      end


      def destroy
        @activity.destroy
        redirect_to activities_url, notice: "Activity was successfully destroyed."
      end


      def set_activity
        @activity = Activity.find(params[:id])
      end


      def activity_params
        params.require(:activity).permit(
          :title, :description, :date, :location,
          :capacity, :what_to_bring, :rules, :notes, :cost, :duration
        )
      end
end
