class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.time :time
      t.date :date
      t.date :end_date
      t.string :location
      t.date :rsvp_deadline
      t.boolean :childcare
      t.string :sponsors
      t.decimal :cost, precision: 8, scale: 2

      t.timestamps
    end
  end
end
