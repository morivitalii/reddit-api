class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include Pundit

  after_action :verify_authorized
end
