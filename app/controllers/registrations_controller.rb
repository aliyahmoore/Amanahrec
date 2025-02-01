class RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def my_registrations
    @registrations = current_user.registrations.includes(:registrable)
  end

  # Create registration for activity/event
  def create
    registrable = find_registrable(params[:registrationable_type], params[:registrationable_id])

    if registrable.nil?
      redirect_to root_path, alert: "Invalid registration."
      return
    end

    # Check if the user is already registered
    if registrable.registrations.exists?(user: current_user)
      redirect_to registrable, alert: "You are already registered."
      return
    end
    # Check for capacity
    if registrable.registrations.count >= registrable.capacity
      redirect_to registrable, alert: "Registration is full. Sorry, the capacity has been reached."
      return
    end
    

    # Create a new registration
    registration = registrable.registrations.create!(user: current_user, status: "pending")

    registration.update(status: "successful")

    # Redirect based on the cost of the registrable item (activity/event)
    if registrable.cost.present? && registrable.cost > 0
      redirect_to new_payment_path(paymentable_type: registrable.class.name, paymentable_id: registrable.id)
    else
      redirect_to my_registrations_path, notice: "Registration successful!"
    end
  rescue => e
    redirect_to registrable, alert: "An error occurred while registering: #{e.message}"
  end

  private

  def find_registrable(type, id)
    case type
    when "Activity"
      Activity.find_by(id: id)
    when "Event"
      Event.find_by(id: id)
    else
      nil
    end
  end
end
