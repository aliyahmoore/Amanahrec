class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :registrable, polymorphic: true
  validate :check_capacity, on: :create

  enum status: { pending: "pending", successful: "successful", failed: "failed" }

  def self.register_user(user, registrable)
    # Check if registrable is nil
    return OpenStruct.new(persisted?: false, errors: ["Registrable object cannot be found."]) if registrable.nil?

    # Check if the user is already registered for the given registrable (activity/event)
    if exists?(user: user, registrable: registrable)
      registration = Registration.new
      registration.errors.add(:base, "You are already registered.")
      return registration
    end

    # Create a new registration for the user and registrable
    create(user: user, registrable: registrable, status: :successful)
  end

  def requires_payment?
    registrable&.cost.present? && registrable.cost.positive?
  end

  private

  def check_capacity
    # Only apply this check for Activities, since Events don't have capacity
    if registrable.is_a?(Activity) && registrable.registrations.count >= registrable.capacity
      errors.add(:base, "Registration is full. Sorry, the capacity has been reached.")
    end
  end
end
