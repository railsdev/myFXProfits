class UserMailer < ActionMailer::Base
	def registration_confirmation(user)
		mail(:to => user.email, :subject => "Welcome To MyFXProfits, " + user.name, :from => "myfxprofits.noreply@gmail.com")
	end

	def password_reset(user)
		@user = user
		mail :to => user.email, :subject => "Password Reset", :from => "myfxprofits.noreply@gmail.com"
	end
end
