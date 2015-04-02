class ApplicationController < ActionController::Base
  include UserLoginConcern
  protect_from_forgery with: :exception
end
