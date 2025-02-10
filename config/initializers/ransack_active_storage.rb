module ActiveStorage
    class Attachment < ApplicationRecord
      def self.ransackable_attributes(auth_object = nil)
        # Allow these attributes to be searchable
        [ "blob_id", "created_at", "id", "name", "record_id", "record_type" ]
      end
    end
end
