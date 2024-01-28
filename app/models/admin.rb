class Admin < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  scope :other_admins, ->(admin_id) { where('id <> ?', admin_id) }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def generate_jwt
    JWTEncoder.encode({ admin_id: id })
  end

  def self.from_jwt(token)
    payload = JWTEncoder.decode(token)
    find(payload['admin_id'])
  end
end
