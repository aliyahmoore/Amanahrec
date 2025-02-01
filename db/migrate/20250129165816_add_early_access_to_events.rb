class AddEarlyAccessToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :early_access_for_members, :boolean, default: false, null: false
    add_column :events, :early_access_days, :integer
    add_column :events, :general_registration_start, :datetime
  end
end
