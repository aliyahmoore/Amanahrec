class PaymentsController < ApplicationController
  before_action :set_event, only: [ :create, :success]

  def create
  # Ensure the user is logged in before registering
  unless user_signed_in?
    redirect_to new_user_session_path, alert: "You must be signed in to register for this event."
    return
  end

    # Check if the user has already paid for the event
    if user_has_paid_for_event?
      redirect_to event_path(@event), alert: "You have already registered for this event."
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
      return redirect_to @event, alert: "Session ID is missing."
    end

    process_payment_success(session_id)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  # Initialize the Stripe Checkout session
  def create_stripe_session
    customer = Stripe::Customer.create(
      email: current_user.email,
      name: "#{current_user.first_name} #{current_user.last_name}"
    )

    Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      customer: customer.id,
      line_items: [ {
        price_data: {
          currency: "usd",
          product_data: {
            name: @event.title,
            description: @event.description
          },
          unit_amount: (@event.cost * 100).to_i
        },
        quantity: 1
      } ],
      mode: "payment",
      success_url: success_url(event_id: @event.id, session_id: "{CHECKOUT_SESSION_ID}"),
      cancel_url: cancel_url(event_id: @event.id),
      metadata: {
        user_id: current_user.id,
        event_id: @event.id,
        location: @event.location,
        start_date: @event.start_date,
        end_date: @event.end_date
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
          amount: @event.cost,
          status: "succeeded",
          user_id: current_user.id,
          event_id: @event.id,
          is_recurring: false,
          recurring_type: nil,
          payment_date: Time.zone.now
        )

        redirect_to event_path(@event), notice: "Payment successful! Thank you for registering."
      else
        redirect_to event_path(@event), alert: "Payment was not completed."
      end
    rescue Stripe::InvalidRequestError => e
      Rails.logger.error("Error retrieving session: #{e.message}")
      redirect_to event_path(@event), alert: "Error retrieving payment details."
    end
  end

  # Generate the success URL
  def success_url(event_id:, session_id:)
    "#{root_url}payments/success?event_id=#{event_id}&session_id=#{session_id}"
  end

  # Generate the cancel URL
  def cancel_url(event_id:)
    "#{root_url}events/#{event_id}"
  end

  # Check if the current user has already paid for the event
  def user_has_paid_for_event?
    Payment.exists?(user_id: current_user.id, event_id: @event.id, status: "succeeded")
  end
end
