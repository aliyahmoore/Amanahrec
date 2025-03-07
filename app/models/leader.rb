class Leader < ApplicationRecord
    has_one_attached :image

    def self.ransackable_attributes(auth_object = nil)
        [ "created_at", "description", "id", "id_value", "name", "position", "updated_at" ]
      end
end
