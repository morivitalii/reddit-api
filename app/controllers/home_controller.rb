class HomeController < ApplicationController
  before_action -> { authorize(HomePolicy) }

  def index
    request.variant = Browser.new(request.user_agent).device.mobile? ? :mobile : :desktop
  end
end
