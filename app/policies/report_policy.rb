# frozen_string_literal: true

class ReportPolicy < ApplicationPolicy
  def index?
    return false unless user_signed_in?

    global_context? ? user_moderator_somewhere? : (user_global_moderator? || user_sub_moderator?)
  end

  alias comments? index?

  def show?
    user_signed_in? && (user_global_moderator? || user_sub_moderator?)
  end

  def create?
    user_signed_in?
  end

  alias new? create?

  def permitted_attributes_for_create
    [:text]
  end

  class Scope
    attr_accessor :user, :scope

    def initialize(context, scope)
      @user = context
      @scope = scope
    end

    def resolve
      if user_global_moderator?
        scope
      else
        ReportsQuery.new(scope).from_subs_where_user_moderator(user)
      end
    end
  end

  private

  def user_moderator_somewhere?
    user.moderators.present?
  end
end
