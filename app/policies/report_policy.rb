# frozen_string_literal: true

class ReportPolicy < ApplicationPolicy
  def index?
    return false unless user_signed_in?
    return true if user_global_moderator?
    return user_moderator_somewhere? if global_context?

    sub_context? ? user_sub_moderator? : false
  end

  alias comments? index?

  def show?
    return false unless user_signed_in?
    return true if user_global_moderator?

    sub_context? ? user_sub_moderator? : false
  end

  def create?
    user_signed_in?
  end

  alias new? create?

  def permitted_attributes_for_create
    [:text]
  end

  class Scope < ApplicationPolicy
    attr_accessor :user, :sub, :scope

    def initialize(context, scope)
      @user = context.user
      @sub = context.sub
      @scope = scope
    end

    def resolve
      if user_global_moderator?
        scope
      else
        ReportsQuery.new(scope).subs_where_user_moderator(user)
      end
    end
  end

  private

  def user_moderator_somewhere?
    user.moderators.present?
  end
end
