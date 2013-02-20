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
      if params[:user][:paid]
        @user.trial = false 
        @user.paid  = true
      else 
        @user.paid  = false
        @user.trial = true
      end

    if @user.save
        UserMailer.registration_confirmation(@user).deliver
        sign_in @user
        if @user.paid
          redirect_to '/Account'
        else 
        redirect_to "/"
        end
    else  
    render 'new'
    end
  end
end
