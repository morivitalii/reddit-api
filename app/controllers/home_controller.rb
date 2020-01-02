class HomeController < ActionController::Base
  include Authentication
  include Authorization
  include Pundit

  after_action :verify_authorized

  before_action -> { authorize(HomePolicy) }

  def index
    request.variant = Browser.new(request.user_agent).device.mobile? ? :mobile : :desktop
  end
end
