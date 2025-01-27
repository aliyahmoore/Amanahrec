class PaymentsController < ApplicationController
  before_action :set_event, only: [:create, :success]

  def create
    payment = initialize_payment_record

    stripe_session = create_stripe_session(payment)

    payment.update!(stripe_payment_id: stripe_session.id)

    redirect_to stripe_session.url, allow_other_host: true
  end

  def success
    session_id = params[:session_id]

    if session_id.blank?
      return redirect_to @event, alert: 'Session ID is missing.'
    end

    process_payment_success(session_id)
  end

  private

  # Set the event for controller actions
  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: 'Event not found.'
  end

  # Initialize a new payment record in the database
  def initialize_payment_record
    Payment.create!(
      stripe_payment_id: nil,
      amount: @event.cost,
      status: 'pending',
      user_id: current_user.id,
      event_id: @event.id,
      is_recurring: false,
      recurring_type: nil,
      payment_date: nil
    )
  end

  # Create a Stripe Checkout Session
  def create_stripe_session(payment)
    customer = Stripe::Customer.create(
      email: current_user.email,
      name: "#{current_user.first_name} #{current_user.last_name}"
    )

    Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer: customer.id,
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: @event.title,
            description: @event.description
          },
          unit_amount: (@event.cost * 100).to_i
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: success_url(event_id: @event.id, session_id: '{CHECKOUT_SESSION_ID}'),
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

  # Handle successful payment logic
  def process_payment_success(session_id)
    begin
      session = Stripe::Checkout::Session.retrieve(session_id)

      if session.payment_status == 'paid'
        payment = Payment.find_by(stripe_payment_id: session.id)

        if payment
          payment.update!(status: 'succeeded', payment_date: Time.zone.now)
          redirect_to event_path(@event), notice: 'Payment successful! Thank you for registering.'
        else
          redirect_to event_path(@event), alert: 'Payment record not found in the database.'
        end
      else
        redirect_to event_path(@event), alert: 'Payment was not completed.'
      end
    rescue Stripe::InvalidRequestError => e
      Rails.logger.error("Error retrieving session: #{e.message}")
      redirect_to event_path(@event), alert: 'Error retrieving payment details. Please contact support.'
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
end