class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include RateLimits
  include Pundit

  after_action :verify_authorized

  private

  helper_method :sidebar_rules
  def sidebar_rules
    @sidebar_rules ||= pundit_user.community.rules.order(id: :asc).all
  end

  helper_method :sidebar_moderators
  def sidebar_moderators
    @sidebar_moderators ||= ModeratorsQuery.new(pundit_user.community.moderators).recent(10).includes(:user)
  end
end
