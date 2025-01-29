class Membership < ApplicationRecord
  belongs_to :user
  has_many :payments, as: :payable

  def active?
    status == "active"
  end
end
