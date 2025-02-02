class AddRecurrenceToActivities < ActiveRecord::Migration[7.2]
  def change
    add_column :activities, :recurrence_pattern, :string
    add_column :activities, :recurrence_days, :string
  end
end
