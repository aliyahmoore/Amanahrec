class Event < ApplicationRecord
    has_many_attached :images
    has_and_belongs_to_many :users

    validates :title, presence: true
    validates :description, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :location, presence: true
    validates :rsvp_deadline, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }
    validates :early_access_days, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
    validates :general_registration_start, presence: true, if: -> { early_access_for_members? }
    
    
     # Check if the event is currently in the early access period
    def early_access_period?
        early_access_for_members && Time.current >= early_access_days && Time.current < general_registration_start
    end
    
      # Check if general registration is open
    def general_registration_open?
        Time.current >= general_registration_start
    end
end
