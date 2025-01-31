class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :registrable, polymorphic: true

  # Enum defines the possible values for 'status'
  enum status: { pending: "pending", successful: "successful", failed: "failed" }
end
