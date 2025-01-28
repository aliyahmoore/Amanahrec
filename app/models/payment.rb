class Payment < ApplicationRecord
  belongs_to :event
  belongs_to :activity
  belongs_to :user
end
