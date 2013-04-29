require 'twilio-ruby'

account_sid = ENV['TWILIO_SID']
auth_token = ENV['TWILIO_AUTH']

@client = Twilio::REST::Client.new account_sid, auth_token