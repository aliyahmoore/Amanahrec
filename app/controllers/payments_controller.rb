class PaymentsController < ApplicationController
  before_action :set_paymentable, only: [ :create, :success ]

  include Findable
  def create
    return redirect_to new_user_session_path, alert: "You must be signed in to register." unless user_signed_in?

    if current_user.has_paid_for?(@paymentable)
      redirect_to @paymentable.is_a?(Membership) ? root_url : paymentable_path, alert: paymentable_alert_message
      return
    end

    stripe_session = PaymentService.new(current_user, @paymentable, root_url).create_stripe_session
    redirect_to stripe_session.url, allow_other_host: true
  end

  def success
    session_id = params[:session_id]

    if session_id.blank?
      return redirect_to @paymentable, alert: "Session ID is missing."
    end

    @paymentable = find_paymentable(params[:paymentable_type], params[:paymentable_id])

    unless @paymentable
      return redirect_to root_url, alert: "Invalid paymentable type or ID."
    end

    if PaymentProcessingService.new(current_user, @paymentable, session_id).process_payment
      message = @paymentable.is_a?(Membership) ? "Thank you for subscribing." : "Registration successful."
      redirect_to paymentable_success_path, notice: message
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
    @paymentable.is_a?(Membership) ? root_url : polymorphic_path(@paymentable)
  end

  def paymentable_alert_message
    @paymentable.is_a?(Membership) ? "You are already subscribed." : "You have already registered."
  end

  def paymentable_success_path
    @paymentable.is_a?(Membership) ? root_url : polymorphic_path(@paymentable)
  end
end
