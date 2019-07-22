# frozen_string_literal: true

class ThingPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    user_signed_in? && (context.user.id == record.user_id || context.user.moderator?(record.sub))
  end

  alias update? edit?

  def tag?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  alias explicit? tag?
  alias spoiler? tag?
  alias ignore_reports? tag?

  def receive_notifications?
    user_signed_in? && context.user.id == record.user_id
  end

  def actions?
    user_signed_in?
  end

  def permitted_attributes
    attributes = []

    attributes.push(:receive_notifications) if receive_notifications?
    attributes.push(:explicit) if tag?
    attributes.push(:spoiler) if explicit?
    attributes.push(:tag) if spoiler?
    attributes.push(:ignore_reports) if ignore_reports?

    attributes
  end
end