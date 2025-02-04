class Activity < ApplicationRecord
    has_one_attached :image

    # Default value for recurrence_days if nil
    after_initialize :set_default_recurrence_days, if: :new_record?

    # Callback to save recurrence_days as a string
    before_save :process_recurrence_days, if: :recurring?

    validates :title, :description, :start_date, :end_date, :location, presence: true
    validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    has_many :payments, as: :paymentable
    has_many :registrations, as: :registrable
    validates :recurrence_pattern, inclusion: { in: %w[daily weekly], message: "%{value} is not a valid recurrence pattern" }, if: :recurring?
    validates :recurrence_days, presence: true, if: :recurring?
    validates :general_registration_start, presence: true
    validates :early_access_days, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

    # Check if the activity is recurring
    def recurring?
      recurrence_pattern.present? && recurrence_days.present?
    end

    # Process recurrence days and convert them to a comma-separated string
    def process_recurrence_days
      self.recurrence_days = recurrence_days.is_a?(Array) ? recurrence_days.join(",") : recurrence_days
    end

    # Get the next occurrence based on the recurrence pattern and days
    def next_occurrence
      return unless recurring?

      current_time = Time.current

      if recurrence_pattern == "daily"
        return start_date if current_time < start_date
        start_date + 1.day
      end

      if recurrence_pattern == "weekly"
        days_of_week = recurrence_days_array
        find_next_weekday_occurrence(days_of_week, current_time)
      end
    end

    # Convert recurrence_days string to an array for easier manipulation
    def recurrence_days_array
      return [] if recurrence_days.blank?
      recurrence_days.is_a?(String) ? recurrence_days.split(",").map(&:strip) : Array(recurrence_days)
    end

    def set_default_recurrence_days
      self.recurrence_days ||= []
    end

    # Calculate the early registration start date
    def early_registration_start
      return nil unless general_registration_start.present? && early_access_days.present?
      general_registration_start - early_access_days.days
    end

    # Check if the activity is currently in the early access period
    def early_access_period?
      return false unless early_access_for_members && early_registration_start.present?
      Time.current.between?(early_registration_start, general_registration_start)
    end

    # Check if general registration is open
    def general_registration_open?
      return false if general_registration_start.nil?
      Time.current >= general_registration_start
    end

    # Determine if a user can register
    def can_register?(user)
      return false unless user
      return general_registration_open? unless user.member?
      early_access_period? || general_registration_open?
    end

    has_many :payments, as: :paymentable
end
