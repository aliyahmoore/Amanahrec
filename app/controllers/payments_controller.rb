class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paymentable, only: [ :create, :success ]

  include Findable

  def create
    # Ensure user is signed in
    return redirect_to new_user_session_path, alert: "You must be signed in to register." unless user_signed_in?

    # Check if the user has already registered or if the activity/event is full
    registration_service = RegistrationService.new(current_user, @paymentable)

    if registration_service.capacity_reached?
      return redirect_to @paymentable, alert: "Registration is full. Sorry, the capacity has been reached."
    end

    if current_user.has_paid_for?(@paymentable)
      redirect_to paymentable_success_path, alert: paymentable_alert_message
      return
    end

    # Handle payment for Event or Activity
    if @paymentable.is_a?(Event) || @paymentable.is_a?(Activity)
      stripe_session = PaymentService.new(current_user, @paymentable, root_url).create_stripe_session
      redirect_to stripe_session.url, allow_other_host: true
    # Handle payment for Membership
    elsif @paymentable.is_a?(Membership)
      stripe_session = PaymentService.new(current_user, @paymentable, root_url).create_stripe_session
      redirect_to stripe_session.url, allow_other_host: true
    else
      redirect_to root_url, alert: "Invalid paymentable type."
    end
  end

  def success
    session_id = params[:session_id]

    if session_id.blank?
      return redirect_to @paymentable, alert: "Session ID is missing."
    end

    # Ensure the paymentable exists
    @paymentable = find_paymentable(params[:paymentable_type], params[:paymentable_id])

    unless @paymentable
      return redirect_to root_url, alert: "Invalid paymentable type or ID."
    end

    # Process payment
    if PaymentProcessingService.new(current_user, @paymentable, session_id).process_payment
      if @paymentable.is_a?(Event) || @paymentable.is_a?(Activity)
        register_user_for_event_or_activity
      elsif @paymentable.is_a?(Membership)
        # For Membership, just confirm the subscription/payment
        confirm_membership_subscription
      else
        redirect_to root_url, alert: "Invalid paymentable type."
      end
    else
      redirect_to @paymentable, alert: "Payment was not completed. Please try again."
    end
  end

  def cancel_subscription
    if SubscriptionCancellationService.new(current_user).cancel
      redirect_to root_url, notice: "Your membership has been successfully canceled."
    else
      redirect_to edit_user_registration_path, alert: "Error canceling subscription."
    end
  end

  private

  def paymentable_path
    polymorphic_path(@paymentable)
  end

  def paymentable_alert_message
    "You have already registered for this #{@paymentable.class.name.downcase}."
  end

  def paymentable_success_path
    polymorphic_path(@paymentable)
  end

  def register_user_for_event_or_activity
    registration_service = RegistrationService.new(current_user, @paymentable)

    if registration_service.register_user
      redirect_to my_registrations_path, notice: "Registration successful."
    else
      redirect_to @paymentable, alert: "Registration failed."
    end
  end

  def confirm_membership_subscription
    # For Membership, after payment, simply acknowledge the subscription
    redirect_to root_url, notice: "Thank you for subscribing to our membership."
  end
end
