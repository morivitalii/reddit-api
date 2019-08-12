# frozen_string_literal: true

class ReportPolicy < ApplicationPolicy
  def posts?
    user_signed_in? && (sub_context? ? user_moderator? : user_moderator_somewhere?)
  end

  alias comments? posts?

  def show?
    user_signed_in? && user_moderator?
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
      if sub_context?
        scope
      else
        ReportsQuery.new(scope).in_subs_moderated_by_user(user)
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
