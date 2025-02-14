class AddDescriptionAndImageToMediaMentions < ActiveRecord::Migration[7.2]
  def change
    add_column :media_mentions, :description, :text
    add_column :media_mentions, :image, :string
  end
end
