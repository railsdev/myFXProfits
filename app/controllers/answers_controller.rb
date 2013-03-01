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
    @answer.post_id = params["post_id"]
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
    data = {}
    data["answers"] = @post.answers
    data["post_id"] = @post.id
    render partial: "answers/answers", object: data
  end
end
