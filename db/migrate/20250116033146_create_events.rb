class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.time :time
      t.date :date
      t.string :location
      t.date :rsvp_deadline
      t.boolean :childcare
      t.string :sponsors
      t.decimal :cost, precision: 8, scale: 2
      t.time :end_time

      t.timestamps
    end
  end
end
