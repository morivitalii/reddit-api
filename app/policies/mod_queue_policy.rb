# frozen_string_literal: true

class ModQueuePolicy < ApplicationPolicy
  def posts?
    user_signed_in? && (sub_context? ? user_moderator? : user_moderator_somewhere?)
  end

  alias comments? posts?

  class PostScope < ModQueuePolicy
    attr_reader :user, :scope

    def initialize(context, scope)
      @user = context.user
      @scope = scope
    end

    def resolve
      if sub_context?
        scope
      else
        PostsQuery.new(scope).in_subs_moderated_by_user(user)
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
      if sub_context?
        scope
      else
        CommentsQuery.new(scope).in_subs_moderated_by_user(user)
      end
    end
  end

  private

  def user_moderator_somewhere?
    user.moderators.present?
  end

  def sub_context?
    sub.present? && sub.url != "all"
  end
end