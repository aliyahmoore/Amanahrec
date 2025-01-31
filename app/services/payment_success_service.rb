class PaymentSuccessService
    def initialize(user, paymentable, session_id)
      @user = user
      @paymentable = paymentable
      @session_id = session_id
    end
  
    def process_success_payment
      session = Stripe::Checkout::Session.retrieve(@session_id)
  
      if session.payment_status == "paid"
        create_payment_record(session)
        update_membership_status(session) if @paymentable.is_a?(Membership)
        true
      else
        false
      end
    rescue Stripe::InvalidRequestError => e
      Rails.logger.error("Error retrieving session: #{e.message}")
      false
    end
  
    private
  
    def create_payment_record(session)
      Payment.create!(
        stripe_payment_id: session.id,
        amount: @paymentable.is_a?(Membership) ? 10.0 : @paymentable.cost,
        status: "succeeded",
        user_id: @user.id,
        paymentable: @paymentable,
        is_recurring: @paymentable.is_a?(Membership),
        recurring_type: @paymentable.is_a?(Membership) ? "monthly" : nil
      )
    end
  
    def update_membership_status(session)
      customer = Stripe::Customer.retrieve(session.customer)
      subscription = Stripe::Subscription.retrieve(session.subscription)
      @paymentable.update!(
        status: "active",
        start_date: Time.now,
        end_date: Time.now + 1.month,
        stripe_customer_id: customer.id,
        stripe_subscription_id: subscription.id
      )
    end
  end