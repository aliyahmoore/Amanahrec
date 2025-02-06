class AddCapacityToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :capacity, :integer
  end
end
