class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :remember_token, :firstname, :lastname, :paid, :trial

	has_secure_password
	before_save { self.email.downcase! }
	before_save :create_remember_token

	validates :password, presence:true , length: {minimum: 5, maximum: 20}

	validates :password_confirmation, presence: true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness:  { case_sensitive: false }

	def password_change
	    save!
	end
	
	def create_remember_token
	    self.remember_token = SecureRandom.urlsafe_base64
	end
end