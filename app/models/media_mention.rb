class MediaMention < ApplicationRecord
  has_one_attached :image
  validates :name, :link, :published_date, :organization_name, :description, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "id_value", "link", "name", "organization_name", "published_date", "updated_at" ]
  end
end
