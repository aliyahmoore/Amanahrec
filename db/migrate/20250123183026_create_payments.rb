class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.string :stripe_payment_id
      t.decimal :amount
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.boolean :is_recurring
      t.string :recurring_type
      t.datetime :payment_date

      t.timestamps
    end
  end
end
