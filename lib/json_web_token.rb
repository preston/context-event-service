class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      tmp = {exp: exp.to_i}.merge!(payload)
      JWT.encode(tmp, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue
      # We don't need to throw errors, just return nil if JWT is invalid or expired.
      nil
    end
  end
end
