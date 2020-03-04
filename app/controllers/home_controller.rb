class HomeController < ActionController::Base
  include ForgeryProtection
  include Authentication
  include Pundit
  include Authorization

  before_action -> { authorize(HomePolicy) }
  after_action :verify_authorized
  layout "application"

  def index
    request.variant = Browser.new(request.user_agent).device.mobile? ? :mobile : :desktop
  end

  private

  def pundit_user
    Context.new(current_user, nil)
  end
end
