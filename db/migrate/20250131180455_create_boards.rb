class CreateBoards < ActiveRecord::Migration[7.2]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :position
      t.text :description

      t.timestamps
    end
  end
end
