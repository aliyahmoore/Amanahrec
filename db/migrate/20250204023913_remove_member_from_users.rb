class RemoveMemberFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :member, :boolean
  end
end
