class RegistrationService
    def initialize(user, registrable)
      @user = user
      @registrable = registrable
    end

    # Main method to register the user for the event or activity
    def register_user
      # Check if the event/activity has reached capacity
      return false if capacity_reached?

      # Check if the user is already registered for this event/activity
      return false if already_registered?

      # If all checks pass, create the registration
      registration = Registration.create(
        user_id: @user.id,
        registrable: @registrable,
        status: :successful  # Assuming the payment is successful
      )

      # Return true if registration was successful
      registration.persisted?
    end

    private

    # Check if the registrable has reached capacity
    def capacity_reached?
      @registrable.is_a?(Activity) && @registrable.registrations.count >= @registrable.capacity
    end

    # Check if the user is already registered for the event/activity
    def already_registered?
      Registration.exists?(user: @user, registrable: @registrable)
    end
end
