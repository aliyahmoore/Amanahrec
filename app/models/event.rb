class Event < ApplicationRecord
    has_many_attached :images

    validates :title, presence: true
    validates :description, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :location, presence: true
    validates :rsvp_deadline, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }

    has_many :payments, as: :paymentable
    has_many :registrations, as: :registrable
    validates :early_access_days, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
    validates :general_registration_start, presence: true, if: -> { early_access_for_members? }

  # Calculate the early registration start date
  def early_registration_start
    return nil unless general_registration_start.present? && early_access_days.present?
    general_registration_start - early_access_days.days
  end

  # Check if the event is currently in the early access period
  def early_access_period?
    return false unless early_access_for_members && early_registration_start.present?
    Time.current.between?(early_registration_start, general_registration_start)
  end

  # Check if general registration is open
  def general_registration_open?
    general_registration_start.present? && Time.current >= general_registration_start
  end

  # Determine if a user can register
  def can_register?(user)
    return false unless user
    return general_registration_open? unless user.member?
    early_access_period? || general_registration_open?
  end
end
