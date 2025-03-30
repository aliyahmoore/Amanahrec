class RegistrationService
    def initialize(user, registrable)
      @user = user
      @registrable = registrable
    end

  def register_user(number_of_adults, number_of_kids)
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
end

class RegistrationError < StandardError; end
