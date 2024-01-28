class Api::ApplicationController < ActionController::Base
  before_filter :authenticate_user!, except: [:login, :logout]
end
