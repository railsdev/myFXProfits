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
		if params[:search]
			@search = Post.search do
			fulltext params[:search]
			end
			@posts = @search.results
		else
			@posts = Post.paginate(:page => params[:page], :per_page => 5, :order => 'created_at DESC')
		end
	end

	def deletePost
		@post = Post.find_by_id(params[:id])
		@post.destroy
		redirect_to '/posts'
	end

end
