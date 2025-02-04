module Registrable
    extend ActiveSupport::Concern
  
    included do
      validates :general_registration_start, presence: true
      validates :early_access_days, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
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
  end