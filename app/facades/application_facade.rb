# frozen_string_literal: true

class ApplicationFacade
  attr_reader :user, :community

  def initialize(context)
    @user = context.user
    @community = context.community
  end

  def communities_moderated_by_user
    return [] if user.blank?

    @_communities_moderated_by_user ||= CommunitiesQuery.new.with_user_moderator(user).all
  end

  def communities_followed_by_user
    return [] if user.blank?

    @_communities_followed_by_user ||= CommunitiesQuery.new.with_user_follower(user).all
  end

  def rules
    @_rules ||= community.rules.order(id: :asc).all
  end

  def recent_moderators
    @_recent_moderators ||= ModeratorsQuery.new(community.moderators).recent(10).includes(:user).all
  end
end