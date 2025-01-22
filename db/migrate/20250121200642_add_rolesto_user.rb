class AddRolestoUser < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :role, foreign_key: true, null: false, default: 2
  end
end
