class PaymentService
  def initialize(user, paymentable, root_url)
    @user = user
    @paymentable = paymentable
    @root_url = root_url
  end

  def create_stripe_session
    customer = Stripe::Customer.create(
      email: @user.email,
      name: "#{@user.first_name} #{@user.last_name}"
    )

    mode = @paymentable.is_a?(Membership) ? "subscription" : "payment"

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
        paymentable_type: @paymentable.class.name
      }
    )
  end

  def success_url
    "#{@root_url}payments/success?paymentable_type=#{@paymentable.class.name}&paymentable_id=#{@paymentable.id}&session_id={CHECKOUT_SESSION_ID}"
  end

  def cancel_url
    if @paymentable.is_a?(Trip)
      "#{@root_url}trips/#{@paymentable.id}"
    else
      "#{@root_url}activities/#{@paymentable.id}"
    end
  end

  private

  def line_items
    items = []
    items << adult_line_item 
    items << kid_line_item
    items
  end

  def adult_line_item
    {
      price_data: {
        currency: "usd",
        unit_amount: (payment_amount * 100).to_i, # Full price
        product_data: {
          name: "Adult Ticket",
          description: "Full-priced ticket for an adult",
          images: payment_image
        }
      },
      adjustable_quantity: {
        enabled: true,
        minimum: 1,
        maximum: 99
      },
      quantity: 1
    }
  end

  def kid_line_item
    {
      price_data: {
        currency: "usd",
        unit_amount: (payment_amount * 0.7 * 100).to_i, # 30% discount
        product_data: {
          name: "Child Ticket",
          description: "Discounted ticket for a child",
          images: payment_image
        }
      },
      adjustable_quantity: {
        enabled: true,
        minimum: 0,
        maximum: 99
      },
      quantity: 1
    }
  end

  def payment_amount
    @paymentable.is_a?(Membership) ? 1000 : @paymentable.cost
  end

  def payment_image
    if @paymentable.is_a?(Trip)
      @paymentable.images.attached? ? [@paymentable.images.first.url] : []
    else
      @paymentable.image.attached? ? [@paymentable.image.url] : []
    end
  end
end
