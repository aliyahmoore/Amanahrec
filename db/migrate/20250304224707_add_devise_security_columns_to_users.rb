class AddDeviseSecurityColumnsToUsers < ActiveRecord::Migration[7.2]
  def change
    # Password Expirable
    add_column :users, :password_changed_at, :datetime

    # Secure Validatable (can be used with additional columns if needed)
    add_column :users, :password_archived_at, :datetime
  end
end
