class AddPostIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :post_id, :int
  end
end
