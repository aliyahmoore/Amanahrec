module EarlyAccessable
    extend ActiveSupport::Concern

    included do
      validates :general_registration_start, presence: true
      validates :early_access_days, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
      validate :end_date_after_start_date
      validate :general_registration_start_before_start_date
    end

    def early_registration_start
      return nil unless general_registration_start.present? && early_access_days.present?
      general_registration_start - early_access_days.days
    end

    def early_access_period?
      return false unless early_access_for_members && early_registration_start.present?
      Time.current.between?(early_registration_start, general_registration_start)
    end

    def general_registration_open?
      general_registration_start.present? && Time.current >= general_registration_start
    end

    def can_register?(user)
      return false unless user
      if user.membership_active?
        early_access_period? || general_registration_open?
      else
        general_registration_open?
      end
    end

    def registration_status
        return "Closed" if Time.current > end_date
        return "Member Registrations Open, General Registration Opens In:" if early_access_for_members && Time.current < general_registration_start
        "General registration is now open!"
      end


    def end_date_after_start_date
      return unless start_date && end_date && end_date < start_date
      errors.add(:end_date, "can't be earlier than the start date")
    end

    def general_registration_start_before_start_date
      return if general_registration_start.nil? || start_date.blank?
      if self.is_a?(Trip) && general_registration_start > start_date
        errors.add(:general_registration_start, "date can't be later than the event start date")
      elsif self.is_a?(Activity) && general_registration_start > start_date
        errors.add(:general_registration_start, "date can't be later than the activity start date")
      end
    end
end
