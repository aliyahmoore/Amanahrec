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
      line_items = if @paymentable.is_a?(Membership)
        [
          {
            price_data: {
              currency: "usd",
              product: ENV["STRIPE_MEMBERSHIP_PRODUCT_ID"],
              recurring: { interval: "month" },
              unit_amount: 1000 # $10 in cents
            },
            quantity: 1
          }
        ]
        # Events and activities are regular payments
      else
        [
          {
            price_data: {
              currency: "usd",
              product_data: {
                name: @paymentable.title,
                description: @paymentable.description
              },
              unit_amount: (@paymentable.cost * 100).to_i
            },
            quantity: 1
          }
        ]
      end
  
      # Stripe third party for payment checkout
      Stripe::Checkout::Session.create(
        payment_method_types: ["card"],
        customer: customer.id,
        line_items: line_items,
        mode: mode,
        success_url: success_url,
        cancel_url: cancel_url,
        metadata: {
          user_id: @user.id,
          paymentable_id: @paymentable.id,
          paymentable_type: @paymentable.class.name,
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
  end