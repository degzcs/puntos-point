class Api::ApplicationController < ActionController::Base
  before_filter :authenticate_user!, except: [:login, :logout]

  def authenticate_user!
    warden.authenticate!(:api_jwt)
  end
end
