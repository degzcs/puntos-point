class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def generate_jwt
    JWTEncoder.encode({ user_id: id })
  end

  def self.from_jwt(token)
    payload = JWTEncoder.decode(token)
    find(payload['user_id'])
  end
end
