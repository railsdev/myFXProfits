class RemoveTrialFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :trial
  end

  def down
    add_column :users, :trial, :boolean
  end
end
