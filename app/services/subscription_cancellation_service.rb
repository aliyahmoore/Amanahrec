class SubscriptionCancellationService
  def initialize(user)
    @user = user
  end

  # Cancel subscription
  def cancel
    # Retrieve Stripe subscription
    stripe_subscription = Stripe::Subscription.retrieve(@user.membership.stripe_subscription_id)
    stripe_subscription.cancel

    # Update membership status
    @user.membership.update(status: "canceled")

    # Update payment status
    payment = @user.payments.find_by(is_recurring: true, status: "succeeded")
    payment.update!(status: "canceled") if payment

    true
  rescue Stripe::StripeError => e
    Rails.logger.error("Error canceling subscription: #{e.message}")
    false
  end
end
