class Post < ActiveRecord::Base
	belongs_to :user
	has_many :answers
	attr_accessible :body, :user_id
	validates :body, presence: :true

end
