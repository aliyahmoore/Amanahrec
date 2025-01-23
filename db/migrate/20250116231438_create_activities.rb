class CreateActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :activities do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.string :location
      t.integer :capacity
      t.text :what_to_bring
      t.text :rules
      t.text :notes
      t.decimal :cost, precision: 8, scale: 2
      t.integer :duration

      t.timestamps
    end
  end
end
