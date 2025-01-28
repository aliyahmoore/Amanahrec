class PaymentsController < ApplicationController
  before_action :set_paymentable, only: [:create, :success]

  def create
    # Ensure the user is logged in before registering
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "You must be signed in to register."
      return
    end

    # Check if the user has already paid for the event/activity
    if user_has_paid_for_paymentable?
      redirect_to @paymentable, alert: "You have already registered."
      return
    end

    # Create the Stripe Checkout session
    stripe_session = create_stripe_session

    # Redirect the user to Stripe Checkout
    redirect_to stripe_session.url, allow_other_host: true
  end

  def success
    session_id = params[:session_id]

    if session_id.blank?
      return redirect_to @paymentable, alert: "Session ID is missing."
    end

    process_payment_success(session_id)
  end

  private

  # Set either an event or activity based on the URL params
  def set_paymentable
    if params[:event_id]
      @paymentable = Event.find(params[:event_id])
    elsif params[:activity_id]
      @paymentable = Activity.find(params[:activity_id])
    end
  end

  # Initialize the Stripe Checkout session
  def create_stripe_session
    customer = Stripe::Customer.create(
      email: current_user.email,
      name: "#{current_user.first_name} #{current_user.last_name}"
    )

    Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      customer: customer.id,
      line_items: [{
        price_data: {
          currency: "usd",
          product_data: {
            name: @paymentable.title,
            description: @paymentable.description
          },
          unit_amount: (@paymentable.cost * 100).to_i
        },
        quantity: 1
      }],
      mode: "payment",
      success_url: success_url(paymentable_type: @paymentable.class.name, paymentable_id: @paymentable.id, session_id: "{CHECKOUT_SESSION_ID}"),
      cancel_url: cancel_url(paymentable_type: @paymentable.class.name, paymentable_id: @paymentable.id),
      metadata: {
        user_id: current_user.id,
        paymentable_id: @paymentable.id,
        paymentable_type: @paymentable.class.name,
        location: @paymentable.location,
        start_date: @paymentable.start_date,
        end_date: @paymentable.end_date
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
          amount: @paymentable.cost,
          status: "succeeded",
          user_id: current_user.id,
          paymentable: @paymentable,  # Polymorphic association
          is_recurring: false,
          recurring_type: nil,
          payment_date: Time.zone.now
        )

        redirect_to @paymentable, notice: "Payment successful! Thank you for registering."
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
    Payment.exists?(user_id: current_user.id, 
                    paymentable_type: @paymentable.class.name, 
                    paymentable_id: @paymentable.id, 
                    status: "succeeded")
  end
end