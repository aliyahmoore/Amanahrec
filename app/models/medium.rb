class Medium < ApplicationRecord
  validates :name, presence: true
  validates :link, presence: true
  validates :description, presence: true, allow_nil: true, allow_blank: true
end
