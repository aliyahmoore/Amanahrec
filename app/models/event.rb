class Event < ApplicationRecord
  include Registrable
  has_many_attached :images
  has_and_belongs_to_many :users
  has_many :payments, as: :paymentable

  validates :title, :description, :start_date, :end_date, :location, :rsvp_deadline, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }

end