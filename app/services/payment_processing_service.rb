class PaymentProcessingService
    # Constants for payment and membership statuses
    PAYMENT_STATUS_SUCCEEDED = "succeeded".freeze
    PAYMENT_STATUS_FAILED = "failed".freeze
    PAYMENT_STATUS_PENDING = "pending".freeze

    MEMBERSHIP_STATUS_ACTIVE = "active".freeze
    MEMBERSHIP_STATUS_PENDING = "pending".freeze

    def initialize(user, paymentable, session_id)
      @user = user
      @paymentable = paymentable
      @session_id = session_id
    end

    # Process the payment based on the payment status
    def process_payment
      session = retrieve_stripe_session

      case session.payment_status
      when "paid"
        handle_successful_payment(session)
      when "unpaid", "failed"
        handle_failed_payment(session)
      when "pending"
        handle_pending_payment(session)
      else
        Rails.logger.error("Unknown payment status: #{session.payment_status}")
        false
      end
    rescue Stripe::StripeError, StandardError => e
      Rails.logger.error("[PaymentProcessingService] Error: #{e.class} - #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      false
    rescue StandardError => e
      Rails.logger.error("Unexpected error: #{e.message}")
      false
    end

    private

    # Retrieve the Stripe session
    def retrieve_stripe_session
      Stripe::Checkout::Session.retrieve(@session_id)
    end

    # Handle a successful payment
    def handle_successful_payment(session)
      create_payment_record(session, PAYMENT_STATUS_SUCCEEDED)
      update_membership_status(session) if @paymentable.is_a?(Membership)
      true
    end

    # Handle a failed payment
    def handle_failed_payment(session)
      create_payment_record(session, PAYMENT_STATUS_FAILED)
      Rails.logger.warn("Payment failed for user #{@user.id} on #{@paymentable.class.name} #{@paymentable.id}")
      false
    end

    # Handle a pending payment
    def handle_pending_payment(session)
      create_payment_record(session, PAYMENT_STATUS_PENDING)
      Rails.logger.info("Payment pending for user #{@user.id} on #{@paymentable.class.name} #{@paymentable.id}")
      false
    end

    # Create a payment record with the given status
    def create_payment_record(session, status)
      Payment.create!(
        stripe_payment_id: session.id,
        amount: @paymentable.is_a?(Membership) ? 10.0 : @paymentable.cost,
        status: status,
        user_id: @user.id,
        paymentable: @paymentable,
        is_recurring: @paymentable.is_a?(Membership),
        recurring_type: @paymentable.is_a?(Membership) ? "monthly" : nil
      )
    end

    # Update the membership status for successful payments
    def update_membership_status(session)
      customer = Stripe::Customer.retrieve(session.customer)
      subscription = Stripe::Subscription.retrieve(session.subscription)

      @paymentable.activate!(customer, subscription) if @paymentable.is_a?(Membership)
    end
end
