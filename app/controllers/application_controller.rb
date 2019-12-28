class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include RateLimits
  include Pundit

  after_action :verify_authorized
end
