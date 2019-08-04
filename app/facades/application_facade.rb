# frozen_string_literal: true

class ApplicationFacade
  attr_reader :user, :sub, :record

  def initialize(context, record = nil)
    @user = context.user
    @sub = context.sub
    @record = record
  end

  def user_ban
    return nil if user_signed_out?

    query_class = BansQuery

    if sub_context?
      scope = query_class.new.user_sub_ban(user, sub)
    else
      scope = query_class.new.user_global_ban(user)
    end

    @_user_ban ||= scope.take
  end

  def subs_where_user_moderator
    return [] if user_signed_out?

    @_subs_where_user_moderator ||= SubsQuery.new.where_user_moderator(user).all
  end

  def subs_where_user_follower
    return [] if user_signed_out?

    @_subs_where_user_follower ||= SubsQuery.new.where_user_follower(user).all
  end

  def rules
    query_class = RulesQuery

    if sub_context?
      scope = query_class.new.sub(sub)
    else
      scope = query_class.new.global
    end

    @_rules ||= scope.all
  end

  def recent_moderators
    query_class = ModeratorsQuery

    if sub_context?
      scope = query_class.new.sub(sub)
    else
      scope = query_class.new.global
    end

    @_recent_moderators ||= scope.limit(10).includes(:user).all
  end

  def recent_pages
    query_class = PagesQuery

    if sub_context?
      scope = query_class.new.sub(sub)
    else
      scope = query_class.new.global
    end

    @_recent_pages ||= scope.limit(10).all
  end

  def user_signed_in?
    user.present?
  end

  def user_signed_out?
    !user_signed_in?
  end

  def sub_context?
    sub.present?
  end

  def global_context?
    !sub_context?
  end
end