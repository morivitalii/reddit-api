class ApplicationController < ActionController::Base
  include PageNotFound
  include Authentication
  include Authorization
  include RateLimits
  include Pundit

  after_action :verify_authorized

  private

  helper_method :communities_moderated_by_user
  def communities_moderated_by_user
    return [] if current_user.blank?

    @communities_moderated_by_user ||= CommunitiesQuery.new.with_user_moderator(current_user).all.to_a
  end

  helper_method :communities_followed_by_user
  def communities_followed_by_user
    return @communities_followed_by_user if defined?(@communities_followed_by_user)
    return [] if current_user.blank?

    @communities_followed_by_user = CommunitiesQuery.new.with_user_follower(current_user).all.to_a

    # Delete those where user is moderator
    @communities_followed_by_user.reject! { |community| communities_moderated_by_user.include?(community) }

    @communities_followed_by_user
  end

  helper_method :sidebar_rules
  def sidebar_rules
    @sidebar_rules ||= pundit_user.community.rules.order(id: :asc).all
  end

  helper_method :sidebar_moderators
  def sidebar_moderators
    @sidebar_moderators ||= ModeratorsQuery.new(pundit_user.community.moderators).recent(10).includes(:user).decorate
  end
end
