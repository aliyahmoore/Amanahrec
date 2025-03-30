class RegistrationsController < ApplicationController
  before_action :check_approval
  before_action :set_registrable, only: [ :create ]
  ALLOWED_REGISTRABLE_TYPES = [ "Activity", "Trip" ].freeze

  def create
    if Registration.exists?(user: current_user, registrable: @registrable)
      flash[:alert] = "You are already registered for this event."
      redirect_to @registrable
      return
    end

    registration_service = RegistrationService.new(current_user, @registrable)
    number_of_adults = params[:number_of_adults].to_i
    number_of_kids = params[:number_of_kids].to_i

    begin
      # Register the user through the service
      @registration = registration_service.register_user(number_of_adults, number_of_kids)

      # If the registration is successful, check for payment
      if @registration.requires_payment?
        # Redirect to the payment page if payment is required
        redirect_to new_payment_path(paymentable: @registrable), notice: "Please proceed with payment."
      else
        # If no payment is required, redirect to the registrations page
        redirect_to my_registrations_path, notice: "Registration successful!"
      end
    rescue RegistrationError => e
      # If there was an error (like capacity full or already registered), show the error message
      redirect_to @registrable, alert: e.message
    end
  end

  def my_registrations
    @registrations = current_user.registrations.preload(:registrable).order(:created_at)
    @grouped_registrations = current_user.registrations.preload(:registrable).group_by(&:registrable_type)
  end

  private

  # Sets the registrable (Event or Activity) based on the provided params
  def set_registrable
    if ALLOWED_REGISTRABLE_TYPES.include?(params[:registrable_type])
      @registrable = params[:registrable_type].constantize.find_by!(id: params[:registrable_id])
       Rails.logger.debug "Registrable found: #{@registrable.inspect}"
    end
  rescue ActiveRecord::RecordNotFound
    # Handle case where the record is not found
    redirect_to root_path, alert: t("errors.registration.not_found")
  end
end
