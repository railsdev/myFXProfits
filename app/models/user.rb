class User < ActiveRecord::Base

	#Accessible Attributes
  	attr_accessible :email, :name, :password, :password_confirmation, :remember_token, :firstname,
  	:lastname, :paid, :registered, :password_reset_token, :phone, :avatar, :stripe_token, :last_4_digits, :expiry_date

	has_attached_file :avatar, styles: { thumb: '100x100>', square: '200x200#',	medium: '300x300>'}

	#Validations and other stuff
	has_many :posts
	has_many :answers

	before_update :valid_phone

	has_secure_password

	before_save { self.email.downcase! }
	before_save :create_remember_token

	validates :name,
	:presence =>  {:message => "cant be blank"},
	uniqueness: {:message => "already taken", case_sensitive: false }

	validates :firstname,
	:presence => {:message => "cant be blank"}

	validates :lastname,
	:presence => {:message => "cant be blank"}

	validates :password, :presence => :true, length: {minimum: 5, maximum: 20}, :on => :create
	validates :password_confirmation, :presence => :true, :on => :create

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, :presence => {:message => "can't be blank"},
	format: { with: VALID_EMAIL_REGEX, :message => "Invalid" },
	uniqueness: {:message => "already taken", case_sensitive: false }


	def password_change
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

	private

	def valid_phone
		if !phone.nil?
			validates :phone, uniqueness: {:message => "already taken", case_sensitive: false }, length: {minimum: 7, maximum: 7}
		end
	end

end