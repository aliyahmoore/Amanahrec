class CombineEventDateAndTimeToDatetime < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :event_datetime, :datetime


    remove_column :events, :date, :date
    remove_column :events, :time, :time
  end
end
