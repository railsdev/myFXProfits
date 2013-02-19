class SessionsController < ApplicationController

  def new
   if signed_in?
    redirect_to '/'
   end
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to '/'
    else
      flash.now[:error] = 'Invalid email/password combination' 
      render 'new'
    end
  end

  def destroy
    self.current_user = nil
    cookies.delete(:trading_token)
    redirect_to '/login'
  end
end