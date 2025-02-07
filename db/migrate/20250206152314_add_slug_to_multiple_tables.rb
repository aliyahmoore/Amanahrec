class AddSlugToMultipleTables < ActiveRecord::Migration[7.2]
  def change
        # Add slug column to events table
        add_column :events, :slug, :string
        add_index :events, :slug, unique: true

        # Add slug column to activities table
        add_column :activities, :slug, :string
        add_index :activities, :slug, unique: true
  end
end
