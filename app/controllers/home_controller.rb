class HomeController < ActionController::Base
  include Authentication
  include Authorization
  include Pundit

  before_action -> { authorize(HomePolicy) }
  after_action :verify_authorized
  layout "application"

  def index
    request.variant = Browser.new(request.user_agent).device.mobile? ? :mobile : :desktop
  end
end
