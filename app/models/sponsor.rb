class Sponsor < ApplicationRecord
    has_one_attached :logo

    validates :link, presence: true
    def self.ransackable_attributes(auth_object = nil)
        [ "created_at", "id", "name", "url", "updated_at" ]
      end

    def self.ransackable_associations(auth_object = nil)
        [ "logo_attachment", "logo_blob" ]
      end
end
