class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :registrable, polymorphic: true

  validates :status, inclusion: {in: %w[pending confirmed canceled]}
end
