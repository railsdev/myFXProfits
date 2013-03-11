class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :send_number

      t.timestamps
    end
  end
end
