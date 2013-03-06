class PostsController < ApplicationController
	before_filter :session_exists
	require 'kaminari'

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
		@posts = Post.paginate(:page => params[:page], :per_page => 5)
	end

	def deletePost
		@post = Post.find_by_id(params[:id])
		@post.destroy
		redirect_to '/posts'
	end

end
