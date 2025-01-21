class Medium < ApplicationRecord
  validates :name, :link, :published_date, :organization_name, presence: true
  validates :description, presence: true, allow_nil: true, allow_blank: true
end
