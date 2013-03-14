class UsersController < ApplicationController
before_filter :session_exists, :only => [:edit, :paypal, :account]
respond_to :html, :json

  def new
  	if signed_in?
	  redirect_to root_path
    end
    @user = User.new
  end

  def reset
    if signed_in?
      redirect_to root_path
    end
  @user = User.find_by_email(params[:email])
  end

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
        redirect_to edit_user_path
  end

  def update
    @user = User.find(params[:id])
      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
          format.json { head :ok }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @user.errors.full_messages, :status => :unprocessable_entity }
        end
      end
    sign_in @user
  end

  def paypal
    @user = current_user
  end

  def paypal_checkout
    user = current_user
    redirect_to user.paypal.checkout_url(
        :return_url =>  confirmpayment_url,
        :cancel_url =>  root_url
        )
  end

  def confirm
    @user = current_user
    if params[:PayerID]
        @user.paypal_customer_token = params[:PayerID]
        @user.paypal_payment_token  = params[:token]
        @user.registered = true
      end
    logger.debug(@user.paypal_customer_token)
    logger.debug(@user.paypal_payment_token )
    @user.save!
  end

  def create
    @user = User.new(params[:user])
    if @user.save
        UserMailer.registration_confirmation(@user).deliver
        sign_in @user
       if @user.paid
          redirect_to paypal_checkout_path
       else
       redirect_to root_path
       end
    else
    render 'new'
    end
  end

end
