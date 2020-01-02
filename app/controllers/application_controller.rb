class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include ForgeryProtection
  include Authentication
  include Pundit
  include Authorization
  include RateLimiting

  after_action :verify_authorized
end
