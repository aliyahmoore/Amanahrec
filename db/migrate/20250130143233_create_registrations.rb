class CreateRegistrations < ActiveRecord::Migration[7.2]
  def change
    execute <<-SQL
      CREATE TYPE registration_status AS ENUM ('pending', 'successful', 'failed');
    SQL

    create_table :registrations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :registrable, polymorphic: true, null: false
      t.column :status, :registration_status, default: 'pending', null: false

      t.timestamps
    end
  end
end
