class ApiJwtStrategy < Warden::Strategies::Base
  def valid?
    api_token.present?
  end

  def authenticate!
    admin = Admin.from_jwt(api_token)

    if admin
      success!(user)
    else
      fail!('Invalid email or password')
    end
  end

  private

  def api_token
    env['HTTP_AUTHORIZATION'].to_s.remove('Bearer ')
  end
end
