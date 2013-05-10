class VideosController < ApplicationController
  before_filter :session_exists
  before_filter :admin_exists, :only => [:new, :deleteVideo]
  require 'kaminari'
  require 'panda'


  def index

  	@videos = Video.paginate(:page => params[:page], :per_page => 5, :order => 'created_at DESC')

    @encodings = []
    @videos.each do |v|
      @original_video = v.panda_video
      @encodings << @original_video.encodings["h264"]
    end


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
    @video.creationDate =  @video.created_at.strftime("%B #{@video.created_at.day.ordinalize}, %Y")
    @video.save!
    redirect_to :action => :show, :id => @video.id
  end

  def deleteVideo
    @video = Video.find_by_id(params[:id])
    @post.destroy
    redirect_to '/videos'
  end

end
