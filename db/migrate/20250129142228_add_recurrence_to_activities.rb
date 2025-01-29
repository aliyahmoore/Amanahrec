class AddRecurrenceToActivities < ActiveRecord::Migration[7.2]
  def change
    add_column :activities, :recurrence_pattern, :string
    add_column :activities, :recurrence_days, :string
    add_column :activities, :recurrence_time, :time
  end
end
