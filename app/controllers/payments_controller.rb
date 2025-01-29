class PaymentsController < ApplicationController
  before_action :set_paymentable, only: [:create, :success]

  def create
    # Ensure the user is logged in before registering
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "You must be signed in to register."
      return
    end

    # Check if the user has already paid for the event/activity or has an active membership
    if user_has_paid_for_paymentable?
      if @paymentable.is_a?(Membership)
        redirect_to root_url, alert: "You are already subscribed."
      else
        redirect_to @paymentable, alert: "You have already registered."
      end
      return
    end

    # Create the Stripe Checkout session
    stripe_session = create_stripe_session

    # Redirect the user to Stripe Checkout
    redirect_to stripe_session.url, allow_other_host: true
  end

  # Upon completion of payment
  def success
    session_id = params[:session_id]

    if session_id.blank?
      return redirect_to @paymentable, alert: "Session ID is missing."
    end

    # Find the paymentable (Event, Activity, or Membership)
    @paymentable = find_paymentable(params[:paymentable_type], params[:paymentable_id])

    unless @paymentable
      return redirect_to root_url, alert: "Invalid paymentable type or ID."
    end

    process_payment_success(session_id)
  end

  private

  # Set either an event, activity, or membership for payment
  def set_paymentable
    @paymentable = find_paymentable(params[:paymentable_type], params[:paymentable_id])

    unless @paymentable
      redirect_to root_url, alert: "Unable to find the requested paymentable item."
    end
  end

  # Find the paymentable object
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

  # Initialize the Stripe Checkout session
  def create_stripe_session
    customer = Stripe::Customer.create(
      email: current_user.email,
      name: "#{current_user.first_name} #{current_user.last_name}"
    )

    # Set payment mode and pricing based on the paymentable type
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

    Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      customer: customer.id,
      line_items: line_items,
      mode: mode,
      success_url: success_url(paymentable_type: @paymentable.class.name, paymentable_id: @paymentable.id, session_id: "{CHECKOUT_SESSION_ID}"),
      cancel_url: cancel_url(paymentable_type: @paymentable.class.name, paymentable_id: @paymentable.id),
      metadata: {
        user_id: current_user.id,
        paymentable_id: @paymentable.id,
        paymentable_type: @paymentable.class.name,
      }
    )
  end

  # Create the payment record after success
  def process_payment_success(session_id)
    begin
      session = Stripe::Checkout::Session.retrieve(session_id)

      if session.payment_status == "paid"
        Payment.create!(
          stripe_payment_id: session.id,
          amount: @paymentable.is_a?(Membership) ? 10.0 : @paymentable.cost, # Membership cost or paymentable cost
          status: "succeeded",
          user_id: current_user.id,
          paymentable: @paymentable,  # Polymorphic association
          is_recurring: @paymentable.is_a?(Membership)? true : false,
          recurring_type: @paymentable.is_a?(Membership) ? "monthly" : nil
        )

        # Update membership status and end_date if it's a membership
        if @paymentable.is_a?(Membership)
          @paymentable.update!(status: "active", start_date: Time.now, end_date: Time.now + 1.month)
        end


        # Customize the redirect based on the paymentable type
        if @paymentable.is_a?(Membership)
          redirect_to root_url, notice: "Payment successful! Thank you for subscribing."
        else
          redirect_to @paymentable, notice: "Payment successful! Thank you for registering."
        end
      else
        redirect_to @paymentable, alert: "Payment was not completed."
      end
    rescue Stripe::InvalidRequestError => e
      Rails.logger.error("Error retrieving session: #{e.message}")
      redirect_to @paymentable, alert: "Error retrieving payment details."
    end
  end

  # Generate the success URL
  def success_url(paymentable_type:, paymentable_id:, session_id:)
    "#{root_url}payments/success?paymentable_type=#{paymentable_type}&paymentable_id=#{paymentable_id}&session_id=#{session_id}"
  end

  # Generate the cancel URL
  def cancel_url(paymentable_type:, paymentable_id:)
    if paymentable_type == "Event"
      "#{root_url}events/#{paymentable_id}"
    else
      "#{root_url}activities/#{paymentable_id}"
    end
  end

  # Check if the current user has already paid for the event/activity
  def user_has_paid_for_paymentable?
    if @paymentable.is_a?(Membership)
      @paymentable.active? # Check active memberships
    else
      Payment.exists?(user_id: current_user.id,
                      paymentable_type: @paymentable.class.name,
                      paymentable_id: @paymentable.id,
                      status: "succeeded")
    end
  end
end