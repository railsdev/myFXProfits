class AddTwilNumberToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :twil_number, :integer
  end
end
