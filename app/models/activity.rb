class Activity < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :date, presence: true
    validates :location, presence: true
    validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
