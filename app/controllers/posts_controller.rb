class PostsController < ApplicationController
	before_filter :session_exists
	respond_to :html, :json
	require 'kaminari'

	def new
		@post = Post.new
	end

  def create
    @post = Post.new(params[:post])

    if @post.postType.nil?
    	@post.postType = "Other"
    end

   	@post.user_id = @user.id

	  if @post.save
	    redirect_to '/posts'
		else
			redirect_to '/posts/new'
		end
	end

	def index
			@posts = Post.paginate(:page => params[:page], :per_page => 5, :order => 'created_at DESC')
	end

	def deletePost
		@post = Post.find_by_id(params[:id])
		@post.destroy
		redirect_to '/posts'
	end

end
