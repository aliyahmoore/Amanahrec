class Activity < ApplicationRecord
    has_many_attached :images

    validates :title, :description, :start_date, :end_date, :location, presence: true
    validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

    validate :end_date_after_start_date
    def end_date_after_start_date
        if end_date.present? && start_date.present? && end_date < start_date
          errors.add(:end_date, "can't be earlier than the start date")
        end
      end
end
