class AddRoleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :role, null: false, foreign_key: true
  end
end
