class Post < ActiveRecord::Base
	belongs_to :user
	attr_accessible :content, :user_id
	validates :content, presence: :true
  has_man
end
