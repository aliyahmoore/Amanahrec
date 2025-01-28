class CreateMediaMentions < ActiveRecord::Migration[7.2]
  def change
    create_table :media_mentions do |t|
      t.string :name, null: false
      t.string :link, null: false
      t.date :published_date, null: false
      t.string :organization_name, null: false

      t.timestamps
    end
  end
end
