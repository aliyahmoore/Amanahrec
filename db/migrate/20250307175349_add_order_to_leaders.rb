class AddOrderToLeaders < ActiveRecord::Migration[7.2]
  def change
    add_column :leaders, :order, :integer

    add_index :leaders, [ :role, :position ], unique: true
  end
end
