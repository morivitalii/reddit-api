class ApiApplicationController < ActionController::API
  include ForgeryProtection
  include Authentication
  include Pundit
  include Authorization
  include RateLimits

  after_action :verify_authorized
end
