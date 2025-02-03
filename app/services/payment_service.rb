class PaymentService
    def initialize(user, paymentable, root_url)
      @user = user
      @paymentable = paymentable
      @root_url = root_url
    end

    # Create the stripe session with customer info
    def create_stripe_session
      customer = Stripe::Customer.create(
        email: @user.email,
        name: "#{@user.first_name} #{@user.last_name}"
      )

      # Membership payment is a subscription
      mode = @paymentable.is_a?(Membership) ? "subscription" : "payment"
      def line_items
        [ {
          price_data: {
            currency: "usd",
            unit_amount: payment_amount,
            product: product_id, # This will return the product ID for Membership or nil for others
            recurring: recurring_data, # Will be nil unless it's a Membership
            product_data: payment_product_data # For non-Membership types
          },
          quantity: 1
        } ]
      end

      # Stripe third party for payment checkout
      Stripe::Checkout::Session.create(
        payment_method_types: [ "card" ],
        customer: customer.id,
        line_items: line_items,
        mode: mode,
        success_url: success_url,
        cancel_url: cancel_url,
        metadata: {
          user_id: @user.id,
          paymentable_id: @paymentable.id,
          paymentable_type: @paymentable.class.name
        }
      )
    end

    def success_url
      "#{@root_url}payments/success?paymentable_type=#{@paymentable.class.name}&paymentable_id=#{@paymentable.id}&session_id={CHECKOUT_SESSION_ID}"
    end

    def cancel_url
      if @paymentable.is_a?(Event)
        "#{@root_url}events/#{@paymentable.id}"
      else
        "#{@root_url}activities/#{@paymentable.id}"
      end
    end

    private

# Payment amount
def payment_amount
  @paymentable.is_a?(Membership) ? 1000 : (@paymentable.cost * 100).to_i
end

# Product ID for Membership or nil for others
def product_id
  @paymentable.is_a?(Membership) ? ENV["STRIPE_MEMBERSHIP_PRODUCT_ID"] : nil
end

# Recurring data for Membership or nil for others
def recurring_data
  @paymentable.is_a?(Membership) ? { interval: "month" } : nil
end

# Product data for non-Membership types (event, activity)
def payment_product_data
  return nil if @paymentable.is_a?(Membership) # Membership is handled by product_id
  { name: @paymentable.title, description: @paymentable.description }
end
end
