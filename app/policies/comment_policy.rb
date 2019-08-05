# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user_signed_in? && !context.user.banned?(context.sub)
  end

  def update?
    user_signed_in? && context.user.moderator?(record.sub) && !context.user.banned?(record.sub) && record.user_id == context.user.id
  end

  alias new? create?
  alias edit? update?

  def approve?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  def destroy?
    user_signed_in? && (record.user_id == context.user.id || context.user.moderator?(record.sub))
  end

  alias remove? destroy?

  def text?
    user_signed_in? && !context.user.banned?(record.sub) && record.user_id == context.user.id
  end

  def ignore_reports?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  def permitted_attributes_for_update
    attributes = []

    attributes.push(:text) if text?
    attributes.push(:ignore_reports) if ignore_reports?

    attributes
  end

  def permitted_attributes_for_destroy
    if context.user.moderator?(record.sub)
      [:reason]
    else
      []
    end
  end
end
