class Partner < ApplicationRecord
    has_one_attached :logo

    def self.ransackable_attributes(auth_object = nil)
        [ "created_at", "id", "name", "updated_at" ]
      end

    def self.ransackable_associations(auth_object = nil)
        [ "logo_attachment", "logo_blob" ]
      end
end
