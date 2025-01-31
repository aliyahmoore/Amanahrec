class PaymentsController < ApplicationController
  before_action :set_paymentable, only: [:create, :success]

  def create
    return redirect_to new_user_session_path, alert: "You must be signed in to register." unless user_signed_in?

    if user_has_paid_for_paymentable?
      redirect_to paymentable_path, alert: paymentable_alert_message
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

    if PaymentSuccessService.new(current_user, @paymentable, session_id).process_payment
      redirect_to paymentable_success_path, notice: "Payment successful! Thank you for #{@paymentable.is_a?(Membership) ? 'subscribing.' : 'registering.'}"
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

  def set_paymentable
    @paymentable = find_paymentable(params[:paymentable_type], params[:paymentable_id])
    redirect_to root_url, alert: "Unable to find the requested paymentable item." unless @paymentable
  end

  def find_paymentable(paymentable_type, paymentable_id)
    case paymentable_type
    when "Activity"
      Activity.find_by(id: paymentable_id)
    when "Event"
      Event.find_by(id: paymentable_id)
    when "Membership"
      Membership.find_by(user: current_user) || Membership.create!(user: current_user, status: "pending")
    else
      nil
    end
  end

  def user_has_paid_for_paymentable?
    if @paymentable.is_a?(Membership)
      @paymentable.active?
    else
      Payment.exists?(user_id: current_user.id,
                      paymentable_type: @paymentable.class.name,
                      paymentable_id: @paymentable.id,
                      status: "succeeded")
    end
  end

  def paymentable_path
    @paymentable.is_a?(Membership) ? root_url : @paymentable
  end

  def paymentable_alert_message
    @paymentable.is_a?(Membership) ? "You are already subscribed." : "You have already registered."
  end

  def paymentable_success_path
    @paymentable.is_a?(Membership) ? root_url : @paymentable
  end
end