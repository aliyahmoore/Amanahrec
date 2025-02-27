class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :registrable, polymorphic: true
  delegate :requires_payment?, to: :registrable

  enum :status, { pending: "pending", successful: "successful", failed: "failed" }

  validates :user_id, :registrable_id, :registrable_type, presence: true
  validates :number_of_adults, :number_of_kids, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.ransackable_associations(auth_object = nil)
    [ "registrable", "registrations", "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "id_value", "registrable_id", "registrable_type", "status", "updated_at", "user_id", "number_of_adults", "number_of_kids", "cost" ]
  end

  # Returns true if the registrable requires payment (i.e., it has a cost)
end
