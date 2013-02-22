class UserMailer < ActionMailer::Base
	def registration_confirmation(user)
		mail(:to => user.email, :subject => "Welcome To MyFXProfits, " + user.name, :from => "farhanm995@gmail.com")
	end

	def password_reset(user)
		@user = user
		mail :to => user.email, :subject => "Password Reset", :from => "farhanm995@gmail.com"
	end
end
