class Event < ApplicationRecord
    include EarlyAccessable
    has_many :payments, as: :paymentable
    has_many :registrations, as: :registrable

    has_many_attached :images

    validates :title, presence: true
    validates :description, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :location, presence: true
    validates :rsvp_deadline, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }
    validate :rsvp_deadline_must_be_valid

    # Calculate the early registration start date
    def start_time
      start_date
    end

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
