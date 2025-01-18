class Event < ApplicationRecord
    # Validations
    validates :title, presence: true
    validates :description, presence: true
    validates :time, presence: true
    validates :date, presence: true
    validates :end_date, presence: true
    validates :location, presence: true
    validates :rsvp_deadline, presence: true
    validates :sponsors, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }

    validate :rsvp_deadline_before_date
end
