class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :registrable, polymorphic: true

  enum :status, { pending: "pending", successful: "successful", failed: "failed" }

  validates :user_id, :registrable_id, :registrable_type, presence: true

  def self.ransackable_associations(auth_object = nil)
    [ "registrable", "registrations", "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "id_value", "registrable_id", "registrable_type", "status", "updated_at", "user_id" ]
  end

  # Returns true if the registrable requires payment (i.e., it has a cost)
  def requires_payment?
    registrable&.cost.to_f.positive?
  end
end
