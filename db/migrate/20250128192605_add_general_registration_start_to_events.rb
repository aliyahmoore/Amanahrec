class AddGeneralRegistrationStartToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :general_registration_start, :datetime
  end
end
