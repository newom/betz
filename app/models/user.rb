class User < ActiveRecord::Base

	has_secure_password

	attr_accessor :remember_token

	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

	validates :un, :presence => true, :uniqueness => true, :length => {:in => 3..20}

	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX

	validates :password, :confirmation => true

	validates_length_of :password, :in => 6..20, :on => :create

	#Returns hash digest of string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(remember_token)
		#return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

end