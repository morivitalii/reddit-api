# frozen_string_literal: true

class ModQueuePolicy < ApplicationPolicy
  def index?
    user_signed_in? && context.user.moderators.present?
  end

  def comments?
    user_signed_in? && context.user.moderators.present?
  end

  class PostScope
    attr_accessor :context, :scope

    def initialize(context, scope)
      @context = context
      @scope = scope
    end

    def resolve
      scope = @scope.where(sub: context.sub)

      if context.user.moderator?
        scope
      else
        scope.joins(sub: :moderators).where(subs: { moderators: { user: context.user } })
      end
    end
  end

  class CommentScope
    attr_accessor :context, :scope

    def initialize(context, scope)
      @context = context
      @scope = scope
    end

    def resolve
      scope = @scope.where(posts: { sub: context.sub })

      if context.user.moderator?
        scope.joins(post: :sub)
      else
        scope.joins(post: { sub: :moderators }).where(posts: { subs: { moderators: { user: context.user } } })
      end
    end
  end
end