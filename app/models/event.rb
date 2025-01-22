class Event < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :datetime, presence: true
    validates :end_datetime, presence: true
    validates :location, presence: true
    validates :rsvp_deadline, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }
end
