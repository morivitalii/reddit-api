# frozen_string_literal: true

class ModQueuePolicy < ApplicationPolicy
  def index?
    user?
  end

  class Scope
    attr_accessor :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.global_moderator?
        scope.joins(thing: :sub)
      else
        scope.joins(thing: { sub: :moderators }).where(things: { subs: { moderators: { user: user } }})
      end
    end
  end
end