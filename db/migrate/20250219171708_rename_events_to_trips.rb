class RenameEventsToTrips < ActiveRecord::Migration[7.2]
  def change
    rename_table :events, :trips
  end
end
