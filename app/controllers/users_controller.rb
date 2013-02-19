class UsersController < ApplicationController

  def new
  	if signed_in?
	  redirect_to '/'
    end
    @user = User.new
  end

  def reset 
    if signed_in?
      redirect_to '/'
    end
  @user = User.find_by_email(params[:email])
end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to "/"
    else  
    render 'new'
    end
  end
end
