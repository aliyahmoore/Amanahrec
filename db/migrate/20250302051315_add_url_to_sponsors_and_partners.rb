class AddUrlToSponsorsAndPartners < ActiveRecord::Migration[7.2]
  def change
    add_column :sponsors, :url, :string
    add_column :partners, :url, :string
  end
end
