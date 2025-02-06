class RegistrationService
    def initialize(user, registrable)
      @user = user
      @registrable = registrable
    end

    def register_user
      raise RegistrationError, "You are already registered for this event or activity." if already_registered?
      raise RegistrationError, "Registration is full. Sorry, the capacity has been reached." if capacity_reached?

      registration = Registration.create!(user: @user, registrable: @registrable, status: :successful)
      registration
    rescue ActiveRecord::RecordInvalid => e
      false
    end

    private

    def already_registered?
      Registration.exists?(user: @user, registrable: @registrable)
    end

    def capacity_reached?
      @registrable.is_a?(Activity) && @registrable.registrations.count >= @registrable.capacity
    end
end

  class RegistrationError < StandardError; end
