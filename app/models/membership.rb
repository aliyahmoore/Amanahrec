class Membership < ApplicationRecord
  belongs_to :user
  has_many :payments, as: :paymentable

  def active?
    status == "active" && end_date > Time.now
  end
end
