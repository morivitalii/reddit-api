# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include PageNotFound
  include Authorization
  include RateLimits
  include Pundit

  after_action :verify_authorized

  private

  helper_method :communities_moderated_by_user
  def communities_moderated_by_user
    return [] if current_user.blank?

    @communities_moderated_by_user ||= CommunitiesQuery.new.with_user_moderator(current_user).all
  end

  helper_method :communities_followed_by_user
  def communities_followed_by_user
    return [] if current_user.blank?

    @communities_followed_by_user ||= CommunitiesQuery.new.with_user_follower(current_user).all
  end

  helper_method :sidebar_rules
  def sidebar_rules
    @sidebar_rules ||= pundit_user.community.rules.order(id: :asc).all
  end

  helper_method :sidebar_moderators
  def sidebar_moderators
    @sidebar_moderators ||= ModeratorsQuery.new(pundit_user.community.moderators).recent(10).includes(:user).all
  end
end
