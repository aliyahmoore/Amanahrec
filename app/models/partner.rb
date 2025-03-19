class Partner < ApplicationRecord
    has_one_attached :logo
    validates :name, :link, presence: true

    def self.ransackable_attributes(auth_object = nil)
        [ "created_at", "id", "name", "link", "updated_at" ]
      end

    def self.ransackable_associations(auth_object = nil)
        [ "logo_attachment", "logo_blob" ]
      end
end
