class Membership < ApplicationRecord
  belongs_to :user
  has_many :payments, as: :paymentable
  MEMBERSHIP_STATUS_ACTIVE = "active".freeze

  def active?
    status == "active"
  end

  def activate!(customer, subscription)
    update!(
      status: MEMBERSHIP_STATUS_ACTIVE,
      start_date: Time.now,
      end_date: nil, 
      stripe_customer_id: customer.id,
      stripe_subscription_id: subscription.id
    )
  end
end
