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

  def update_text?
    author?
  end

  def update_ignore_reports?
    moderator?
  end

  def update_removed_reason?
    moderator?
  end

  def permitted_attributes_for_create
    [:text]
  end

  def permitted_attributes_for_update
    attributes = []
    attributes.push(:text) if update_text?
    attributes.push(:ignore_reports) if update_ignore_reports?
    attributes
  end

  def permitted_attributes_for_destroy
    attributes = []
    attributes.push(:reason) if update_removed_reason?
    attributes
  end

  private

  def author?
    user? && user.id == record.user_id
  end
end
