class AddBodyToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :body, :string
  end
end
