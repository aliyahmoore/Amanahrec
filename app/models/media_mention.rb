class MediaMention < ApplicationRecord
  validates :name, :link, :published_date, :organization_name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "link", "name", "organization_name", "published_date", "updated_at"]
  end
end
