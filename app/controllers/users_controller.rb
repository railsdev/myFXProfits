class UsersController < ApplicationController
before_filter :session_exists, :only => [:edit, :checkout]
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

  def create
    @user = User.new(params[:user])
    if @user.save
      begin
        UserMailer.registration_confirmation(@user).deliver
      rescue Exception => e
        logger.debug(e)
      end
        sign_in @user
       if @user.paid
          redirect_to checkout_path
       else
          redirect_to root_path
       end
    else
      render 'new'
    end
  end

  def checkout

    @user = current_user

    if @user.registered?
      flash[:error] = "Your subscription has not yet ended"
      redirect_to root_path
    end
    if request.post?

      logger.debug("--------------------------------------")
      logger.debug("Checkout Started")
      description = @user.email + "'s MyFX Subscription"
      token = params[:stripe_token]
      last_4_digits = params[:last_4_digits]

      # Logging stuffff 
      logger.debug(token)
      logger.debug(last_4_digits)

      begin

        charge = Stripe::Charge.create(
          :amount => 2500, #CENTS
          :currency => "cad",
          :card => token,
          :description => description
        )

        @user.stripe_token = token
        @user.last_4_digits = last_4_digits

        if @user.save
            @user.expiry_date = 7.days.from_now
            @user.registered = true
            @user.save
            sign_in @user
            redirect_to root_path
        else
          flash[:error] = "There was a problem with your payment" 
          render :action => :checkout
        end
        
      rescue Stripe::CardError => e
          flash[:error] = "There was a problem with your payment" 
          render :action => :checkout

      rescue Stripe::StripeError => e
          flash[:error] = "There was a problem with your payment" 
          render :action => :checkout
      end

    end
  end

end
