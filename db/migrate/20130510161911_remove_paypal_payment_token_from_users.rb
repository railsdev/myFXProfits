class RemovePaypalPaymentTokenFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :paypal_payment_token
    remove_column :users, :paypal_recurring_profile_token
    remove_column :users, :paypal_customer_token
  end

  def down
    add_column :users, :paypal_payment_token, :string
	add_column :users, :paypal_recurring_profile_token, :string
	add_column :users, :paypal_customer_token, :string
  end
end
