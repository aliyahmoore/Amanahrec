class Event < ApplicationRecord
    has_many_attached :images
    has_and_belongs_to_many :users

    validates :title, presence: true
    validates :description, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :location, presence: true
    validates :rsvp_deadline, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }
    validates :early_access_days, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
    validates :general_registration_start, presence: true, if: -> { early_access_for_members? }
    
    
    
    
    # Method to calculate the early access start date
  def early_access_start_date
    return nil unless general_registration_start && early_access_days

    general_registration_start - early_access_days.days
  end
end
