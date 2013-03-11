class VideosController < ApplicationController
  before_filter :session_exists, :only => [:new, :index]

  def new
  end

  def index
  end
end
