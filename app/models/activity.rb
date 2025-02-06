class Activity < ApplicationRecord
  include EarlyAccessable
  has_one_attached :image

  validates :title, :description, :start_date, :end_date, :location, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  has_many :registrations, as: :registrable
  has_many :payments, as: :paymentable

  # Simple start_time method that returns the start_date
  def start_time
    start_date
  end
end
