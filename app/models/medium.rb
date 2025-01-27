class Medium < ApplicationRecord
  validates :name, :link, :published_date, :organization_name, presence: true
end
