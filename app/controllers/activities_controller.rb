class ActivitiesController < ApplicationController
  before_action :set_activity, only: [ :show ]
    def index
      @current_activities = Activity.where("start_date >= ?", Time.current).order(start_date: :asc)
      @past_activities = Activity.where("start_date < ?", Time.current).order(start_date: :desc)
    end

    def show
      @can_register = @activity.can_register?(current_user)
    end

    private

    def set_activity
      @activity = Activity.friendly.find(params[:slug])
    end
end
