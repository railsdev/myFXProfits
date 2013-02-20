class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  	def session_exists
	    logger.debug(signed_in?)
	    if !signed_in?
	      redirect_to "/login"
	    end
	end

	def registered
		if !@user.registered
			redirect_to(:back)
		end
	end
end

