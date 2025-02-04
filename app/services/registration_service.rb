class RegistrationService
  def initialize(user, registrable)
    @user = user
    @registrable = registrable
  end

  def register_user
    raise RegistrationError, t("errors.registration.already_registered") if already_registered?
    raise RegistrationError, t("errors.registration.capacity_full") if capacity_reached?

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