module SessionsHelper

	def sign_in(user)
    	cookies[:trading_token] = user.remember_token
    	self.current_user = user
  	end
  	
  	def current_user=(user)
    	@current_user = user
  	end

  	def current_user
    	@current_user ||= User.find_by_remember_token(cookies[:trading_token])
  	end
  	
  	def signed_in?
    	!self.current_user.nil?
  	end
end