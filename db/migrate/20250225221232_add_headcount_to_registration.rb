class AddHeadcountToRegistration < ActiveRecord::Migration[7.2]
  def change
    add_column :registrations, :number_of_adults, :integer, default: 0
    add_column :registrations, :number_of_kids, :integer, default: 0
  end
end
