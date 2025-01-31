class DropDuplicateTables < ActiveRecord::Migration[7.2]
    def change
      drop_table :memberships, if_exists: true
      drop_table :payments, if_exists: true
    end
end
