class RemovePaypalRecurringTokenFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :paypal_recurring_token
  end

  def down
    add_column :users, :paypal_recurring_token, :string
  end
end
