class AddEarlyAccessDaysToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :early_access_days, :integer
  end
end
