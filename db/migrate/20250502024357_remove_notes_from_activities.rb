class RemoveNotesFromActivities < ActiveRecord::Migration[7.2]
  def change
    remove_column :activities, :notes, :text
  end
end
