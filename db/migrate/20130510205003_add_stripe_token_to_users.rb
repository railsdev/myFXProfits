class AddStripeTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_token, :string
    add_column :users, :last_4_digits, :string
  end
end
