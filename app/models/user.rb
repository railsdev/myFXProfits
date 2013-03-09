class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :remember_token, :firstname, :lastname, :paid, :trial, :registered,
  :paypal_payment_token, :paypal_recurring_profile_token, :paypal_customer_token, :password_reset_token, :number, :avatar

	has_attached_file :avatar,
	:styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "assets/avatar.png"

	has_many :posts
	has_many :answers


	validates :password, presence:true , length: {minimum: 5, maximum: 20}, :on => :create
	validates :password_confirmation, presence: true, :on => :create

	validates :number, uniqueness: {:message => "already taken", case_sensitive: false },
	:numericality => { :only_integer => true }

	validates :name,
	:presence =>  {:message => "cant be blank"},
	uniqueness: {:message => "already taken", case_sensitive: false }

	validates :firstname,
	:presence => {:message => "cant be blank"}

	validates :lastname,
	:presence => {:message => "cant be blank"}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, :presence => {:message => "can't be blank"},
	format: { with: VALID_EMAIL_REGEX, :message => "Invalid" },
	uniqueness: {:message => "already taken", case_sensitive: false }
	has_secure_password
	before_save { self.email.downcase! }
	before_save :create_remember_token



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

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_token = self.password_reset_token.to(6)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def create_remember_token
	    self.remember_token = SecureRandom.urlsafe_base64
	end

	def generate_token(column)
		begin
		self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end
end