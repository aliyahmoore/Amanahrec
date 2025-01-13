class CreateActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.datetime :date
      t.text :description
      t.boolean :free

      t.timestamps
    end
  end
end
