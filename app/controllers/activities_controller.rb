class ActivitiesController < ApplicationController
    def index
        @activities = Activity.order(start_date: :desc)
    end


    def show
        @can_register = @activity.can_register?(current_user)
    end
end
