class ChangeNumberFormatInUsers < ActiveRecord::Migration
 def up
   change_column :users, :number, :integer
  end

  def down
   change_column :users, :number, :string
  end
end
