class Membership < ApplicationRecord
  belongs_to :user_id
  has_many :payments, as: :payable
end
