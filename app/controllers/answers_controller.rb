class AnswersController < ApplicationController
	before_filter :session_exists

	def new
		@user = current_user
		@answer = Answer.new
	end

  	def create
  	@user = current_user
    @answer = Answer.new(params[:answer])
   	@post.user_id = @user.id
	    if @post.save
	       redirect_to '/posts'
	  	 
		else 
			redirect_to '/posts/new'
		end
	end

	def index
		@posts = Post.all
	end
end
