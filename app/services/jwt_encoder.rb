class JWTEncoder
  def self.encode(payload)
    JWT.encode(payload, ENV['SECRET_KEY_BASE'])
  end

  def self.decode(token)
    JWT.decode(token, ENV['SECRET_KEY_BASE']).first
  end
end
