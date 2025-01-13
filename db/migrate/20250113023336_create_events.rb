class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.text :description
      t.string :location
      t.boolean :free

      t.timestamps
    end
  end
end
