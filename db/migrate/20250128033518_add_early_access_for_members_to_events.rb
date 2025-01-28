class AddEarlyAccessForMembersToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :early_access_for_members, :boolean
  end
end
