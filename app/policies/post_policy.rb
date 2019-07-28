# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user_signed_in? && !context.user.banned?(context.sub)
  end

  alias new? create?

  def update?
    user_signed_in? && context.user.moderator?(record.sub) && !context.user.banned?(record.sub) && record.user_id == context.user.id
  end

  alias edit? update?

  def approve?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  def destroy?
    user_signed_in? && (record.user_id == context.user.id || context.user.moderator?(record.sub))
  end

  alias new_destroy? destroy?

  def text?
    user_signed_in? && !context.user.banned?(record.sub) && record.user_id == context.user.id
  end

  def tag?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  def explicit?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  def spoiler?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  def ignore_reports?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  def receive_notifications?
    user_signed_in? && context.user.id == record.user_id
  end

  def permitted_attributes_for_update
    attributes = []

    attributes.push(:text) if text?
    attributes.push(:receive_notifications) if receive_notifications?
    attributes.push(:explicit) if tag?
    attributes.push(:spoiler) if explicit?
    attributes.push(:tag) if spoiler?
    attributes.push(:ignore_reports) if ignore_reports?

    attributes
  end

  def permitted_attributes_for_destroy
    if context.user.moderator?(record.sub)
      [:deletion_reason]
    else
      []
    end
  end
end
