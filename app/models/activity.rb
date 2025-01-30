class Activity < ApplicationRecord
    has_many_attached :images

    # Default value for recurrence_days if nil
    after_initialize :set_default_recurrence_days, if: :new_record?

    # Callback to save recurrence_days as a string
    before_save :process_recurrence_days, if: :recurring?

    validates :title, presence: true
    validates :description, presence: true
    validates :date, presence: true
    validates :location, presence: true
    validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
    validates :recurrence_pattern, presence: true, if: :recurring?
    validates :recurrence_days, presence: true, if: :recurring?

    # Check if the activity is recurring
    def recurring?
      recurrence_pattern.present? && recurrence_days.present? && recurrence_time.present?
    end

    # Process recurrence days and convert them to a comma-separated string
    def process_recurrence_days
      self.recurrence_days = recurrence_days.join(",") if recurrence_days.is_a?(Array)
    end

    # Get the next occurrence based on the recurrence pattern and days
    def next_occurrence
      return unless recurring?

      current_time = Time.current
      recurrence_time = current_time.change(hour: self.recurrence_time.hour, min: self.recurrence_time.min, sec: 0)

      if recurrence_pattern == "daily"
        return recurrence_time if current_time < recurrence_time
        recurrence_time + 1.day
      end

      if recurrence_pattern == "weekly"
        days_of_week = recurrence_days_array
        next_occurrence = find_next_weekday_occurrence(days_of_week, current_time, recurrence_time)
        next_occurrence
      end
    end

    # Convert recurrence_days string to an array for easier manipulation
    def recurrence_days_array
      recurrence_days.split(",").map(&:strip) if recurrence_days.present?
    end

    def start_time
        date
    end

    private

    def set_default_recurrence_days
      self.recurrence_days ||= ""
    end
end
