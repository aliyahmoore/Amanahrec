class Payment < ApplicationRecord
  belongs_to :paymentable, polymorphic: true
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    [ "amount", "is_recurring", "paymentable_id", "paymentable_type", "recurring_type", "status", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "paymentable", "user" ]
  end
end
