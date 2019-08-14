# frozen_string_literal: true

class ApplicationFacade
  attr_reader :user, :community, :record

  def initialize(context, record = nil)
    @user = context.user
    @community = context.community
    @record = record
  end

  def user_ban
    return nil if user.blank?

    @_user_ban ||= BansQuery.new(community.bans).with_user(user).take
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

  def pagination_params
    []
  end
end