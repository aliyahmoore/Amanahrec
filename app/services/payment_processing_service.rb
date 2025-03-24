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
      Stripe::Checkout::Session.retrieve(
        @session_id,
        expand: [ "line_items" ]
      )
    end

    # Handle a successful payment
    def handle_successful_payment(session)
      create_payment_record(session, PAYMENT_STATUS_SUCCEEDED)

      line_items = Stripe::Checkout::Session.list_line_items(session.id)
      total_adults = 0
      total_kids = 0

      total_cost = session.amount_total / 100.0

      line_items.data.each do |item|
        quantity = item.quantity
        # Determine if item corresponds to adults or kids (this depends on your Stripe setup)
        if item.description.downcase.include?("adult")
          total_adults += quantity
        elsif item.description.downcase.include?("kid") || item.description.downcase.include?("child")
          total_kids += quantity
        end
  end

  # Create or update the registration record
  if @paymentable.is_a?(Trip) || @paymentable.is_a?(Activity)
    registration = Registration.create!(
      user: @user,
      registrable: @paymentable,
      number_of_adults: total_adults,
      number_of_kids: total_kids,
      status: "successful",
      cost: total_cost
    )
  end
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
      total_cost = session.amount_total / 100.0
      Payment.create!(
        stripe_payment_id: session.id,
        amount: @paymentable.is_a?(Membership) ? 10.0 : total_cost,
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
