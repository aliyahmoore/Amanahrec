class AddPublishedDateAndOrganizationNameToMedia < ActiveRecord::Migration[7.2]
  def change
    add_column :media, :published_date, :date
    add_column :media, :organization_name, :string
  end
end
