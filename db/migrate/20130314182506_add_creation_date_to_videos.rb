class AddCreationDateToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :creationDate, :string
  end
end
