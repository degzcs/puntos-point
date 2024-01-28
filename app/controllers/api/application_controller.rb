class Api::ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, except: [:login, :logout]

  def authenticate_user!
    warden.authenticate!(:api_jwt)
  end

  def serialize_response(response)
    response.map do |item|
      if item.respond_to?(:attributes)
       item.attributes
      end
    end
  end
end
