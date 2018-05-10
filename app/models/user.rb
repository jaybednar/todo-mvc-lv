class User < ActiveRecord::Base	
	has_many :shared_lists 
	has_many :lists, through: :shared_lists

	validates :email, presence: true 
	validates :email, uniqueness: true 
	has_secure_password

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
		end
	end

	def self.find_or_create_by_omniauth(auth_hash)
		self.where(email: auth_hash['info']['email']).first_or_create do |user|
			user.password = SecureRandom.hex 
		end
	end

end
