class Event < ApplicationRecord
    include EarlyAccessable
    has_many :payments, as: :paymentable
    has_many :registrations, as: :registrable

    has_many_attached :images
    
    validates :title, presence: true
    validates :description, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :location, presence: true
    validates :rsvp_deadline, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }
    validates :early_access_days, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
    validates :general_registration_start, presence: true, if: -> { early_access_for_members? }
  
    # Calculate the early registration start date
    def start_time
      start_date
    end
end
