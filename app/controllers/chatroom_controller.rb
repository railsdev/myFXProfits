class ChatroomController < ApplicationController
	before_filter :session_exists
  def index
  	@messages = Message.all
  end
end
