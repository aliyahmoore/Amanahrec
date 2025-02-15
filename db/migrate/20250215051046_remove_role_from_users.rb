class RemoveRoleFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_reference :users, :role, foreign_key: true
  end
end
