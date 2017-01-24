class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  if ENV['RAILS_ENV'] == 'production'
    http_basic_authenticate_with name: ENV.fetch('ADMIN_NAME', 'admin'),
      password: ENV.fetch('ADMIN_PASSWORD', 'password')
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
end
