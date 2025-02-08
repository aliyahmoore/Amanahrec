class Event < ApplicationRecord
    include EarlyAccessable
    extend FriendlyId
    friendly_id :custom_slug, use: :slugged

    def custom_slug
      "#{title}-#{start_date.strftime('%Y-%m-%d')}"
    end
    has_many_attached :images

    validates :title, :description, :start_date, :end_date, :capacity, :location, :rsvp_deadline, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }
    validate :rsvp_deadline_must_be_valid

    has_many :registrations, as: :registrable
    has_many :payments, as: :paymentable

    def start_time
      start_date
    end

    private

    def rsvp_deadline_must_be_valid
      return if rsvp_deadline.blank? || start_date.blank? || general_registration_start.blank?

      if rsvp_deadline >= start_date
        errors.add(:rsvp_deadline, "must be before the event start date")
      end

      if rsvp_deadline < general_registration_start
        errors.add(:rsvp_deadline, "must be after the general registration start date")
      end
    end

    def self.ransackable_attributes(auth_object = nil)
      ["capacity", "childcare", "cost", "early_access_for_members", "end_date", "general_registration_start", "location", "rsvp_deadline","start_date", "title" ]
    end

    def self.ransackable_associations(auth_object = nil)
      ["images_attachments", "images_blobs", "payments", "registrations"]
    end
end
