class Activity < ApplicationRecord
  include EarlyAccessable
  extend FriendlyId
  friendly_id :custom_slug, use: :slugged

  def custom_slug
    [
      [ :title, start_date.strftime("%Y-%m-%d") ] # Combines name and start_date
    ]
  end

  has_one_attached :image

  validates :title, :description, :start_date, :end_date, :location, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  has_many :registrations, as: :registrable
  has_many :payments, as: :paymentable

  def requires_payment?
    cost.to_f > 0
  end
  
  # Simple start_time method that returns the start_date
  def start_time
    start_date
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "capacity", "cost", "early_access_for_members", "end_date", "general_registration_start", "location", "start_date", "title" ]
  end
end
