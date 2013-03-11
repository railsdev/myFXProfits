class AddPostTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :postType, :string
  end
end
