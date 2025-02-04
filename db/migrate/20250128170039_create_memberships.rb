class CreateMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.string :stripe_customer_id
      t.string :stripe_subscription_id
      t.timestamps
    end
  end
end
