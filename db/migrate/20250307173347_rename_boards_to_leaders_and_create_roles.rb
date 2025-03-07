class RenameBoardsToLeadersAndCreateRoles < ActiveRecord::Migration[7.2]
  def change
    rename_table :boards, :leaders

    add_column :leaders, :role, :string
  end
end
