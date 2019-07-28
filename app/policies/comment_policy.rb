# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    user_signed_in? && !context.user.banned?(record.sub)
  end

  def update?
    user_signed_in? && !context.user.banned?(record.sub) && record.user_id == context.user.id
  end

  alias new? create?
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
