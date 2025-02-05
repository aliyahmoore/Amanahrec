class Event < ApplicationRecord
  include EarlyAccessable
  has_many_attached :images
  has_and_belongs_to_many :users
  has_many :payments, as: :paymentable
  has_many :registrations, as: :registrable

  validates :title, :description, :start_date, :end_date, :location, :rsvp_deadline, presence: true
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Calculate the early registration start date



  def start_time
    start_date
  end
end
