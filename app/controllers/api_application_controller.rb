class ApiApplicationController < ActionController::API
  include Pundit
  include Authentication
  include Authorization
  include RateLimits

  after_action :verify_authorized
end
