class AddTotalCostToRegistrations < ActiveRecord::Migration[7.2]
  def change
    add_column :registrations, :cost, :decimal
  end
end
