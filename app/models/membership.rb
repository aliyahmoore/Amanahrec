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

  def self.ransackable_attributes(auth_object = nil)
    ["end_date", "start_date", "status", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["payments", "user"]
  end

end
