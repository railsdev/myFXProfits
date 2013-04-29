class AlertsController < ApplicationController
  before_filter :session_exists


	def new

    if !@user.admin
      redirect_to '/posts'
    end

  end

  def create

    account_sid = ENV['TWILIO_SID']
    auth_token = ENV['TWILIO_AUTH']

    @client = Twilio::REST::Client.new account_sid, auth_token

    twil_number = '+12268872873'
    @users = User.all

    @users.each do |user|

      @client.account.sms.messages.create(
        :from => twil_number,
        :to => "+1#{user.number}",
        :body => params[:alert][:body]
      )

    end

    if true
      redirect_to '/message'
    else
      render 'new'
    end

  end

end
