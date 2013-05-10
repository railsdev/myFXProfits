class SessionsController < ApplicationController

  def new
   if signed_in?
    redirect_to '/'
   end
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user.nil? 
      user = User.find_by_name(params[:session][:email])
    end
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to '/'
    else
      flash.now[:error] = 'Invalid email/password combination' 
      render 'new'
    end
  end

  def destroy
    session[:user_token] = nil
    redirect_to '/'
  end
end
