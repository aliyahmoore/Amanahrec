class RemoveApprovedFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :approved, :boolean
  end
end
