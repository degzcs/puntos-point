class Api::ApplicationController < ActionController::Base
  before_filter :authenticate_user_from_token!, :except => [:login, :logout]
end
