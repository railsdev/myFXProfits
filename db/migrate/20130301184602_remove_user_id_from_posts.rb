class RemoveUserIdFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :userId
  end

  def down
    add_column :posts, :userId, :string
  end
end
