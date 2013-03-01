class AnswersController < ApplicationController
	before_filter :session_exists

	def new
		@user = current_user
		@answer = Answer.new
	end

  	def create
  	@user = current_user
    @answer = Answer.new(params[:answer])
   	@answer.user_id = @user.id
	    if @answer.save
	       redirect_to '/posts'
	  	 
		else 
			redirect_to '/posts/new'
		end
	end

	def index
		@posts = Post.all
	end

	def retrieve
		@post = Post.find(params["id"])
		render partial: "answers/answers", object: @post.answers
	end
end
