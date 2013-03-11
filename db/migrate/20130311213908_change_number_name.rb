class ChangeNumberName < ActiveRecord::Migration

  def down
   remove_column :users, :number, :integer
  end

  def up
   add_column :users, :phone, :integer
  end

end
