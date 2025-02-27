class RegistrationService
    def initialize(user, registrable)
      @user = user
      @registrable = registrable
    end

  def register_user(number_of_adults, number_of_kids)
    raise RegistrationError, "You are already registered for this trip or activity/event." if already_registered?
    raise RegistrationError, "Registration is full. Sorry, the capacity has been reached." if capacity_reached?

    # Proceed with the registration for free activities and events
    registration = Registration.create!(
      user: @user,
      registrable: @registrable,
      status: "pending",
      number_of_adults: number_of_adults,
      number_of_kids: number_of_kids,
      cost: 0.0)

    if @registrable.requires_payment?
      registration # Payment is required, status remains "pending"
    else
      registration.update!(status: "successful")
      registration
    end

    rescue ActiveRecord::RecordInvalid
    raise RegistrationError, "Registration failed due to invalid data."
  end

  private

  def capacity_reached?
      # Handle capacity check for both Activity and Trip
      total_adults = @registrable.registrations.sum(:number_of_adults)
      total_kids = @registrable.registrations.sum(:number_of_kids)

      (total_adults + total_kids) >= @registrable.capacity
  end

  def already_registered?
    Registration.exists?(user: @user, registrable: @registrable)
  end
end

class RegistrationError < StandardError; end
