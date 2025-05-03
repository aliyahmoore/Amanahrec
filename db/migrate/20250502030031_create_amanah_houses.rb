class CreateAmanahHouses < ActiveRecord::Migration[7.2]
  def change
    create_table :amanah_houses do |t|
      t.text :location
      t.text :description

      t.timestamps
    end
  end
end
