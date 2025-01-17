class CreateMedia < ActiveRecord::Migration[7.2]
  def change
    create_table :media do |t|
      t.string :name
      t.string :link
      t.text :description

      t.timestamps
    end
  end
end
