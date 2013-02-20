class UsersController < ApplicationController
before_filter :session_exists, :only => [:paypal, :paypal_checkout]
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
  
  def paypal
    @user = current_user 
  end

  def paypal_checkout
    @user = current_user
      ppr = PayPal::Recurring.new({
        :return_url =>  root_url,
        :cancel_url =>  root_url,
        :description  => "myFXprofits Monthy Subscription",
        :amount     => "50.00",
        :currency   => "USD"
        })
      response = ppr.checkout
      if response.valid?
          redirect_to response.checkout_url
          @user.registered = true
      else 
          raise response.errors.inspect
      end
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
          redirect_to '/updateplan'
        else 
        redirect_to "/"
        end
    else  
    render 'new'
    end
  end
end
