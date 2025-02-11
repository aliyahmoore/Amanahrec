class Activity < ApplicationRecord
  include EarlyAccessable
  extend FriendlyId
  friendly_id :custom_slug, use: :slugged
  before_save :update_slug, if: :date_changed?

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


  # Simple start_time method that returns the start_date
  def start_time
    start_date
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "capacity", "cost", "early_access_for_members", "end_date", "general_registration_start", "location", "start_date", "title" ]
  end

  private

   # Regenerate the slug after the duplicated activity is saved
   def update_slug
    self.slug = custom_slug.first.join("-")
  end

  # Check if the start_date or end_date has changed
  def date_changed?
    start_date_changed? || end_date_changed?
  end
end
