class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Welcome To MyFXProfits, " + user.name, :from => "farhanm995@gmail.com")
  end
end
