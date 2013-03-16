class ApplicationController < ActionController::Base

  protect_from_forgery
  require 'chronic'
  include SessionsHelper

  	def session_exists
	    logger.debug(signed_in?)
	    if signed_in?
	    	@user = current_user

		  else
		  	redirect_to new_user_path
	  end
	end

	def registered
		if !@user.registered
			flash[:notice] = "Nah nigga"
			redirect_to edit_user_path
		end
	end

	def admin_exists
		if !@user.admin
			flash[:notice] = "You do not have the privileges to access that page"
			redirect_to root_path
		end
	end
end

