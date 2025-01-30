class AddEarlyAccessToActivities < ActiveRecord::Migration[7.2]
  def change
    add_column :activities, :early_access_for_members, :boolean
    add_column :activities, :early_access_days, :integer
    add_column :activities, :general_registration_start, :datetime
  end
end
