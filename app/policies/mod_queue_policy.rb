# frozen_string_literal: true

class ModQueuePolicy < ApplicationPolicy
  def index?
    user_signed_in? && context.user.moderators.present?
  end

  class Scope
    attr_accessor :context, :scope

    def initialize(context, scope)
      @context = context
      @scope = scope
    end

    def resolve
      if context.user.moderator?
        scope.joins(thing: :sub)
      else
        scope.joins(thing: { sub: :moderators }).where(things: { subs: { moderators: { user: context.user } }})
      end
    end
  end
end