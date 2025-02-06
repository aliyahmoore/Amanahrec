class RegistrationsController < ApplicationController
    before_action :set_registrable, only: [ :create ]
    ALLOWED_REGISTRABLE_TYPES = [ "Activity", "Event" ]
  
  
    def create
      # Register the user using the Registration model's class method
      registration = Registration.register_user(current_user, @registrable)
  
      if registration.persisted?
        # Check if the registrable requires payment
        if registration.requires_payment?
          # Redirect to the payment page if payment is required
          redirect_to new_payment_path(paymentable: @registrable), notice: "Please proceed with payment."
        else
          # If no payment is required, redirect to the registrations page
          redirect_to my_registrations_path, notice: "Registration successful!"
        end
      else
        # If registration failed, show errors
        redirect_to @registrable, alert: registration.errors.full_messages.to_sentence
      end
    end
  
  
    def my_registrations
      @registrations = current_user.registrations.preload(:registrable).order(:created_at)
      @grouped_registrations = current_user.registrations.preload(:registrable).group_by(&:registrable_type)
    end
  
    private
  
    # Sets the registrable (Event or Activity) based on the provided params
    def set_registrable
      valid_types = [ "Activity", "Event" ]  # Whitelist allowed types
      # Check if the registrable type is in the allowed list
      if valid_types.include?(params[:registrable_type])
        # Safe constantize: Find the class and retrieve the record
        @registrable = params[:registrable_type].constantize.find_by!(id: params[:registrable_id])
      end
    rescue ActiveRecord::RecordNotFound
      # Handle case where the record is not found
      redirect_to root_path, alert: t("errors.registration.not_found")
    end
  
  
    # Finds the registrable object (Event or Activity) by its type and ID
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