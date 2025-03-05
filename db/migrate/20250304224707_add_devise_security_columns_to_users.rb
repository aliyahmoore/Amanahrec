class AddDeviseSecurityColumnsToUsers < ActiveRecord::Migration[7.2]
  def change
    # Password Expirable
    add_column :users, :password_changed_at, :datetime
  end
end
