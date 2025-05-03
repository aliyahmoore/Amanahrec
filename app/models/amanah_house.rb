class AmanahHouse < ApplicationRecord
    validates :description, :location, presence: true
    has_one_attached :image

    def self.ransackable_associations(auth_object = nil)
        ["image_attachment", "image_blob"]
      end
    
      def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "location", "updated_at"]
    end
end
