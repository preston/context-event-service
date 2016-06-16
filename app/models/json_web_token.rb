class JsonWebToken < ActiveRecord::Base

	belongs_to	:user
	validates_presence_of	:user

	validates_presence_of	:expires_at


	def encode
	  data = {sub: self.id, exp: self.expires_at.to_i}
	  JWT.encode(data, Rails.application.secrets.secret_key_base)
	end

	def self.decode(token)
	  body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
	  HashWithIndifferentAccess.new body
	rescue
	  # We don't need to throw errors, just return nil if JWT is invalid or expired.
	  nil
	end

end
