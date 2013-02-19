class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  	def session_exists
	    logger.debug(signed_in?)
	    if !signed_in?
	      redirect_to "/login"
	    end
	end
end

