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

    has_many :payments, as: :paymentable
end
