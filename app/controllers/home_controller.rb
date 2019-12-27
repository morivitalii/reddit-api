class HomeController < ApplicationController
  before_action -> { authorize(:home) }

  def index
    request.variant = Browser.new(request.user_agent).device.mobile? ? :mobile : :desktop
  end
end
