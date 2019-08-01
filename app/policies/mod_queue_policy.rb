# frozen_string_literal: true

class ModQueuePolicy < ApplicationPolicy
  def index?
    return false unless user_signed_in?

    global_context? ? user_moderator_somewhere? : (user_global_moderator? || user_sub_moderator?)
  end

  alias comments? index?

  class PostScope < ModQueuePolicy
    attr_reader :user, :scope

    def initialize(context, scope)
      @user = context.user
      @scope = scope
    end

    def resolve
      if user_global_moderator?
        scope
      else
        PostsQuery.new(scope).from_subs_where_user_is_moderator(user)
      end
    end
  end

  class CommentScope < ModQueuePolicy
    attr_reader :user, :scope

    def initialize(context, scope)
      @user = context.user
      @scope = scope
    end

    def resolve
      if user_global_moderator?
        scope
      else
        CommentsQuery.new(scope).from_subs_where_user_is_moderator(user)
      end
    end
  end

  private

  def user_moderator_somewhere?
    user.moderators.present?
  end
end