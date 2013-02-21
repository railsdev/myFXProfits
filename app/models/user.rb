class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :remember_token, :firstname, :lastname, :paid, :trial, :registered, :paypal_payment_token

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

	def save_with_payment 
		if valid?
			ppr = PayPal::Recurring.new({
				:token => paypal_payment_token,
				:payer_id => paypal_customer_token,
				:description  => "myFXprofits Monthy Subscription",
		        :amount     => "50.00",
		        :currency   => "USD"
				})
		response = ppr.request_payment
		if response.errors.present?
			raise response.errors.inspect
		end

		ppr = PayPal::Recurring.new({
		  :amount          => "50.00",
		  :currency        => "USD",
		  :description  => "myFXprofits Monthy Subscription",
		  :frequency       => 1,
		  :token           => paypal_payment_token,
		  :period          => :monthly,
		  :payer_id        => paypal_customer_token,
		  :start_at        => Time.zone.now
		})
	end
	self.paypal_recurring_profile_token = response.profile_id
end
	
	def create_remember_token
	    self.remember_token = SecureRandom.urlsafe_base64
	end
end