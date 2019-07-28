# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def create?
    user_signed_in? && !context.user.banned?(context.sub)
  end

  alias new? create?

  def update?
    user_signed_in? && !context.user.banned?(context.sub) && record.user_id == context.user.id
  end

  alias edit? update?

  def approve?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  def destroy?
    user_signed_in? && (record.user_id == context.user.id || context.user.moderator?(record.sub))
  end

  alias new_destroy? destroy?

  def permitted_attributes_for_destroy
    if context.user.moderator?(record.sub)
      [:deletion_reason]
    else
      []
    end
  end
end
