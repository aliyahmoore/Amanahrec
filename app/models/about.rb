class About < ApplicationRecord
    has_one_attached :image

    def self.ransackable_attributes(auth_object = nil)
        [ "created_at", "founder", "id", "id_value", "mission", "updated_at", "vision" ]
      end

    def self.ransackable_associations(auth_object = nil)
    [ "image_attachment", "image_blob" ]
    end
end
