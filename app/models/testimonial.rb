class Testimonial < ApplicationRecord
  belongs_to :user
  validates :text, presence: true
  attribute :approved, :boolean, default: false

  def self.ransackable_attributes(auth_object = nil)
    ["approved", "created_at", "id", "id_value", "text", "updated_at", "user_id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
