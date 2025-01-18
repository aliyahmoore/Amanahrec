class Event < ApplicationRecord
    # Validations
    validates :title, presence: true
    validates :description, presence: true
    validates :event_datetime, presence: true
    validates :end_date, presence: true
    validates :location, presence: true
    validates :rsvp_deadline, presence: true
    validates :sponsors, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }
end
