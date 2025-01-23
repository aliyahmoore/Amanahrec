class PaymentsController < ApplicationController
  def new
  end

  def create
    @event = Event.find(params[:event_id])
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: @event.name,
          },
          unit_amount: (@event.cost * 100).to_i, # Convert to cents
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: event_url(@event),
      cancel_url: event_url(@event),
    )

    redirect_to session.url, allow_other_host: true
  end
end
