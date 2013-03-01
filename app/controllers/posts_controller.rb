class PostsController < ApplicationController
	before_filter :session_exists

	def new
		@user = current_user
		@post = Post.new
	end

  def create
  	@user = current_user
    @post = Post.new(params[:post])
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
