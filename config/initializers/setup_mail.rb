ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "myfxprofits.noreply",
  :password             => ENV['EMAIL_PASS'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}
