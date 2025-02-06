class RegistrationService
  def initialize(user, registrable)
    @user = user
    @registrable = registrable
  end

  def register_user
    # Check if the user is already registered
    raise RegistrationError, "You are already registered for this event or activity." if already_registered?
    
    # Check if the capacity is full and prevent registration creation if true
    if capacity_reached?
      raise RegistrationError, "Registration is full. Sorry, the capacity has been reached."
    end

    # Proceed with the registration if no errors
    registration = Registration.create!(user: @user, registrable: @registrable, status: :successful)
    registration
  rescue ActiveRecord::RecordInvalid => e
    false
  end

  def capacity_reached?
    # Handle capacity check for both Activity and Event
    if @registrable.is_a?(Activity)
      @registrable.registrations.count >= @registrable.capacity
    elsif @registrable.is_a?(Event)
      @registrable.registrations.count >= @registrable.capacity
    else
      false
    end
  end

  private

  def already_registered?
    Registration.exists?(user: @user, registrable: @registrable)
  end

end

class RegistrationError < StandardError; end
