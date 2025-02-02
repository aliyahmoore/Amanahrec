class RegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_registrable, only: [ :create ]

  def create
    # Ensure @registrable is not nil
    if @registrable.nil?
      redirect_to root_path, alert: "The event or activity you're trying to register for could not be found."
      return
    end

    # Pass both user and registrable to the register_user method
    registration = Registration.register_user(current_user, @registrable)

    if registration.persisted?
      redirect_to registration.requires_payment? ? new_payment_path(paymentable: @registrable) : my_registrations_path,
                  notice: "Registration successful!"
    else
      redirect_to @registrable, alert: registration.errors.full_messages.to_sentence
    end
  end

  def my_registrations
    @registrations = current_user.registrations.preload(:registrable).order(:created_at)
  end

  private

  def set_registrable
    Rails.logger.debug "registrable_type: #{params[:registrable_type]}, registrable_id: #{params[:registrable_id]}"
    # Ensure params are passed correctly, and find the registrable
    @registrable = find_registrable(params[:registrable_type], params[:registrable_id])

    if @registrable.nil?
      redirect_to root_path, alert: "The event or activity you're trying to register for could not be found."
    end
  end

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
