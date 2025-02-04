class Event < ApplicationRecord
  include EarlyAccessable
  has_many_attached :images
  has_and_belongs_to_many :users
  has_many :payments, as: :paymentable

  validates :title, :description, :start_date, :end_date, :location, :rsvp_deadline, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }

  validate :rsvp_deadline_must_be_valid

  private

  def rsvp_deadline_must_be_valid
    return if rsvp_deadline.blank? || start_date.blank? || general_registration_start.blank?

    if rsvp_deadline >= start_date
      errors.add(:rsvp_deadline, "must be before the event start date")
    end

    if rsvp_deadline < general_registration_start
      errors.add(:rsvp_deadline, "must be after the general registration start date")
    end
  end
end
