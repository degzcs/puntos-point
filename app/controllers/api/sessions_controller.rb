module Api
  class SessionsController < ApplicationController
    def login
      admin = Admin.find_by(email: params[:email])
      if adming && admin.valid_password?(params[:password])
        render json: { token: admin.generate_jwt }
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end

    def logout
      # Implement logout logic if needed
    end
  end
end
