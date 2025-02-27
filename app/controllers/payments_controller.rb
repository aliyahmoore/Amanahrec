class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paymentable, only: [ :create, :success ]

  include Findable

  def create
    return redirect_to root_url, alert: "Invalid paymentable type." unless valid_paymentable?

    stripe_session = PaymentService.new(current_user, @paymentable, root_url).create_stripe_session
    redirect_to stripe_session.url, allow_other_host: true
  end

  def success
    session_id = params[:session_id]

    return redirect_to @paymentable, alert: "Session ID is missing." if session_id.blank?

    @paymentable = find_paymentable(params[:paymentable_type], params[:paymentable_id])
    return redirect_to root_url, alert: "Invalid paymentable type or ID." unless @paymentable

    if PaymentProcessingService.new(current_user, @paymentable, session_id).process_payment
      handle_success
    else
      handle_failure
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

  def valid_paymentable?
    @paymentable.is_a?(Trip) || @paymentable.is_a?(Activity) || @paymentable.is_a?(Membership)
  end

  def handle_success
    if @paymentable.is_a?(Membership)
      confirm_membership_subscription
    elsif @paymentable.is_a?(Trip) || @paymentable.is_a?(Activity)
        redirect_to my_registrations_path, notice: "Payment successful. Your registration is confirmed."
    end
  end

  def handle_failure
    redirect_to @paymentable, alert: "Payment failed or was not completed. Please try again."
  end

  def confirm_membership_subscription
    redirect_to root_url, notice: "Thank you for subscribing to our membership."
  end
end
