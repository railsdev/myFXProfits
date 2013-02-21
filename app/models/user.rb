class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :remember_token, :firstname, :lastname, :paid, :trial, :registered, :paypal_payment_token, :paypal_recurring_profile_token, :paypal_customer_token

	has_secure_password
	before_save { self.email.downcase! }
	before_save :create_remember_token
	validates :password, presence:true , length: {minimum: 5, maximum: 20}

	validates :password_confirmation, presence: true
	validates :name, presence: true
	validates :firstname, presence: true
	validates :lastname, presence: true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness:  { case_sensitive: false }

	def password_change
	    save!
	end

	def paypal
		PaypalPayment.new(self)
	end
	def save_with_payment 
		response = paypal.make_recurring
		self.paypal_recurring_profile_token = response.profile_id
		save!
	end
	
	def create_remember_token
	    self.remember_token = SecureRandom.urlsafe_base64
	end
end