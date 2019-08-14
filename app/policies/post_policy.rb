# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user_signed_in?
  end

  alias new? create?

  def update?
    user_signed_in? && (user_author? || user_moderator?)
  end

  alias edit? update?

  def approve?
    user_signed_in? && user_moderator?
  end

  def destroy?
    user_signed_in? && (user_author? || user_moderator?)
  end

  alias remove? destroy?

  def text?
    user_signed_in? && user_author?
  end

  def explicit?
    user_signed_in? && user_moderator?
  end

  def spoiler?
    user_signed_in? && user_moderator?
  end

  def ignore_reports?
    user_signed_in? && user_moderator?
  end

  def deletion_reason?
    user_signed_in? && user_moderator?
  end

  def permitted_attributes_for_update
    attributes = []
    attributes.push(:text) if text?
    attributes.push(:explicit) if explicit?
    attributes.push(:spoiler) if spoiler?
    attributes.push(:ignore_reports) if ignore_reports?
    attributes
  end

  def permitted_attributes_for_destroy
    attributes = []
    attributes.push(:reason) if deletion_reason?
    attributes
  end

  private

  def user_author?
    user.id == record.user_id
  end
end
