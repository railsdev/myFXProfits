class AddPaypalPaymentTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paypal_payment_token, :string
  end
end
