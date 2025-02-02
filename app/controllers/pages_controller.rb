class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.where(approved: true).order(created_at: :desc)
  end

  def calendar
    @events = Event.all
    @activities = Activity.all

    def calendar
      @events = Event.all
      @activities = Activity.all

      # Date range for the current month
      start_date = Date.today.beginning_of_month
      end_date = Date.today.end_of_month

      # Initialize an array to store recurring activities for the calendar
      @recurring_activities = []

      # Loop through each activity
      @activities.each do |activity|
        # Check if the activity has recurrence days
        if activity.recurrence_days.present?
          # Loop through each recurrence day (e.g., Monday, Tuesday, etc.)
          activity.recurrence_days_array.each do |recurrence_day|
            # Find the first occurrence of the recurrence day in the current month
            current_day = start_date
            while current_day <= end_date
              if current_day.strftime("%A").downcase == recurrence_day.downcase
                # Add the activity for this day to the recurring activities array
                @recurring_activities << { title: activity.title, start_time: current_day }
              end
              current_day += 1.day
            end
          end
        end
      end
    end
  end

  def about
  end

  def partners
  end

  def board
  end
end
