class CreateMediaMentions < ActiveRecord::Migration[7.2]
  def change
    create_table :media_mentions do |t|
      t.string :name
      t.string :link
      t.date :published_date
      t.string :organization_name

      t.timestamps
    end
  end
end
