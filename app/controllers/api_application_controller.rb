class ApiApplicationController < ActionController::API
  include Authentication
  include Authorization
  include Pundit
  include RateLimits

  after_action :verify_authorized
end
