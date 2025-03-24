class AddAdultAndKidCostToActivitiesTrips < ActiveRecord::Migration[7.2]
  def change
    change_table :trips, bulk: true do |t|
      t.decimal :adult_cost, precision: 8, scale: 2, null: false, default: 0.0
      t.decimal :kid_cost, precision: 8, scale: 2, null: true
      t.remove :cost  # Removes the existing cost field
    end

    change_table :activities, bulk: true do |t|
      t.decimal :adult_cost, precision: 8, scale: 2, null: false, default: 0.0
      t.decimal :kid_cost, precision: 8, scale: 2, null: true
      t.remove :cost  # Removes the existing cost field
    end
  end
end
