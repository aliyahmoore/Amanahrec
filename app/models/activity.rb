class Activity < ApplicationRecord
  include Registrable
  has_one_attached :image
  has_many :payments, as: :paymentable

  # Default value for recurrence_days if nil
  after_initialize :set_default_recurrence_days, if: :new_record?

  # Callback to save recurrence_days as a string
  before_save :process_recurrence_days, if: :recurring?

  validates :title, :description, :start_date, :end_date, :location, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :recurrence_pattern, inclusion: { in: %w[daily weekly], message: "%{value} is not a valid recurrence pattern" }, if: :recurring?
  validates :recurrence_days, presence: true, if: :recurring?
  
  # Check if the activity is recurring
  def recurring?
    recurrence_pattern.present? && recurrence_days.present?
  end

  # Process recurrence days and convert them to a comma-separated string
  def process_recurrence_days
    self.recurrence_days = recurrence_days.is_a?(Array) ? recurrence_days.join(",") : recurrence_days
  end

  # Get the next occurrence based on the recurrence pattern and days
  def next_occurrence
    return unless recurring?

    current_time = Time.current

    if recurrence_pattern == "daily"
      return start_date if current_time < start_date
      start_date + 1.day
    end

    if recurrence_pattern == "weekly"
      days_of_week = recurrence_days_array
      find_next_weekday_occurrence(days_of_week, current_time)
    end
  end

  # Convert recurrence_days string to an array for easier manipulation
  def recurrence_days_array
    return [] if recurrence_days.blank?
    recurrence_days.is_a?(String) ? recurrence_days.split(",").map(&:strip) : Array(recurrence_days)
  end

  def set_default_recurrence_days
    self.recurrence_days ||= []
  end
end
