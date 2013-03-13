class VideosController < ApplicationController
  before_filter :session_exists
  require 'kaminari'
  require 'panda'

  def index
  	@videos = Video.paginate(:page => params[:page], :per_page => 5, :order => 'created_at DESC')
  end

  def show
    @video = Video.find(params[:id])
    @original_video = @video.panda_video
    @h264_encoding = @original_video.encodings["h264"]
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.create!(params[:video])
    redirect_to :action => :show, :id => @video.id
  end

end
