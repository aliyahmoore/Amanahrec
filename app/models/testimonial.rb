class Testimonial < ApplicationRecord
  belongs_to :user
  validates :text, presence: true
  attribute :approved, :boolean, default: false
end
