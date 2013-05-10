class RemovePaypalCustomerTokenFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :paypal_customer_token
  end

  def down
    add_column :users, :paypal_customer_token, :string
  end
end
