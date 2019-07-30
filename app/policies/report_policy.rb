# frozen_string_literal: true

class ReportPolicy < ApplicationPolicy
  def index?
    user_signed_in? && context.user.moderators.present?
  end

  def comments?
    user_signed_in? && context.user.moderators.present?
  end

  def show?
    user_signed_in? && context.user.moderator?(context.sub)
  end

  def create?
    user_signed_in?
  end

  alias new? create?

  class Scope
    attr_accessor :context, :scope

    def initialize(context, scope)
      @context = context
      @scope = scope
    end

    def resolve
      scope = @scope.where(sub: context.sub)

      if context.user.moderator?
        scope.joins(:sub)
      else
        scope.joins(sub: :moderators).where(subs: { moderators: { user: context.user } })
      end
    end
  end
end
