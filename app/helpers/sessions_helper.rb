module SessionsHelper
  	def sign_in(user)
      if user.registered?
        if user.expiry_date < Time.now
          user.registered = false 
          user.save
        end
      end
      session[:user_token] = user.remember_token
    end
  	
  	def current_user=(user)
    	@current_user = user
  	end

  	def current_user
    	@current_user ||= User.find_by_remember_token(session[:user_token]) if session[:user_token]
  	end
  	
  	def signed_in?
      !session[:user_token].nil?
  	end
end