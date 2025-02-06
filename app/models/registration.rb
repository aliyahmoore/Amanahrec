class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :registrable, polymorphic: true
  has_many :registrations

  enum :status, { pending: "pending", successful: "successful", failed: "failed" }

  validates :user_id, :registrable_id, :registrable_type, presence: true
  validate :check_existing_registration, on: :create

  # Registers the user for an event/activity (registrable) and returns the registration object
  def self.register_user(user, registrable)
    # If registrable is nil, return an error message
    return OpenStruct.new(persisted?: false, errors: [ "Registrable object cannot be found." ]) if registrable.nil?

    # Check if the user is already registered for the event/activity
    if exists?(user: user, registrable: registrable)
      registration = Registration.new
      registration.errors.add(:base, "You are already registered.")
      return registration
    end

    # Check capacity for the event/activity
    if registrable.is_a?(Activity) && registrable.registrations.count >= registrable.capacity
      registration = Registration.new
      registration.errors.add(:base, "Registration is full. Sorry, the capacity has been reached.")
      return registration
    end

    # Create the registration and set its status to 'successful'
    create(user: user, registrable: registrable, status: :successful)
  end

  # Returns true if the registrable requires payment (i.e., it has a cost)
  def requires_payment?
    registrable&.cost.present? && registrable.cost.positive?
  end

  private

  # Ensures the user is not already registered for the event/activity
  def check_existing_registration
    if self.class.exists?(user: user, registrable: registrable)
      errors.add(:base, "You are already registered for this event or activity.")
    end
  end
end
