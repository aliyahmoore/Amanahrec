class CreateRegistrations < ActiveRecord::Migration[7.2]
  def change
    create_table :registrations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :registrable, polymorphic: true, null: false
      t.string :status

      t.timestamps
    end
  end
end
