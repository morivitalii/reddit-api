# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user?
  end

  def update?
    author? || moderator?
  end

  alias new? create?
  alias edit? update?

  def approve?
    moderator?
  end

  def destroy?
    author? || moderator?
  end

  alias remove? destroy?

  def text?
    author?
  end

  def ignore_reports?
    moderator?
  end

  def removed_reason?
    moderator?
  end

  def permitted_attributes_for_create
    [:text]
  end

  def permitted_attributes_for_update
    attributes = []
    attributes.push(:text) if text?
    attributes.push(:ignore_reports) if ignore_reports?
    attributes
  end

  def permitted_attributes_for_destroy
    attributes = []
    attributes.push(:reason) if removed_reason?
    attributes
  end

  private

  def author?
    user? && user.id == record.user_id
  end
end
