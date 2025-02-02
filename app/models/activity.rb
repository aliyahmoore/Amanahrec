class Activity < ApplicationRecord
    has_one_attached :image

    # Callbacks
    after_initialize :set_default_recurrence_days, if: :new_record?
    before_save :process_recurrence_days, if: :recurring?

    # Validations
    validates :title, :description, :start_date, :end_date, :location, :general_registration_start, presence: true
    validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :recurrence_pattern, inclusion: { in: %w[daily weekly], message: "%{value} is not a valid recurrence pattern" }, if: :recurring?
    validates :recurrence_days, presence: true, if: :recurring?
    validates :early_access_days, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

    validate :end_date_after_start_date
    validate :general_registration_start_before_start_date

    # Public Methods

    def recurring?
      recurrence_pattern.present? && recurrence_days.present?
    end

    def next_occurrence
      return unless recurring?

      current_time = Time.current

      if recurrence_pattern == "daily"
        return start_date if current_time < start_date
        return start_date + 1.day
      end

      find_next_weekday_occurrence(recurrence_days_array, current_time) if recurrence_pattern == "weekly"
    end

    def early_registration_start
      return unless general_registration_start && early_access_days
      general_registration_start - early_access_days.days
    end

    def early_access_period?
      return false unless early_access_for_members && early_registration_start
      Time.current.between?(early_registration_start, general_registration_start)
    end

    def general_registration_open?
      general_registration_start.present? && Time.current >= general_registration_start
    end

    def can_register?(user)
        return false unless user
        return false if Time.current > end_date # Registration closes after event ends

        if user.member?
          return true if early_access_period? || general_registration_open?
        else
          return general_registration_open?
        end

        false
      end

      def registration_status
        return "Closed" if Time.current > end_date
        return "Member Registrations Open, General Registration Opens In:" if early_access_for_members && Time.current < general_registration_start
        "General registration is now open!"
      end

    # Private Methods

    private

    def process_recurrence_days
      self.recurrence_days = recurrence_days.is_a?(Array) ? recurrence_days.join(",") : recurrence_days
    end

    def recurrence_days_array
      return [] if recurrence_days.blank?
      recurrence_days.split(",").map(&:strip)
    end

    def set_default_recurrence_days
      self.recurrence_days ||= []
    end

    def end_date_after_start_date
      return unless start_date && end_date && end_date < start_date
      errors.add(:end_date, "can't be earlier than the start date")
    end

    def general_registration_start_before_start_date
      return if general_registration_start.nil? || start_date.blank?
      return if general_registration_start <= start_date
      errors.add(:general_registration_start, "date can't be later than the start date")
    end
end
