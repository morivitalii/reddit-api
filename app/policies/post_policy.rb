# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user?
  end

  alias new_text? create?
  alias new_link? create?
  alias new_image? create?

  def update?
    author? || moderator?
  end

  def edit?
    author? && record.text?
  end

  def approve?
    moderator?
  end

  def destroy?
    author? || moderator?
  end

  alias remove? destroy?

  def update_text?
    author? && record.text?
  end

  def update_explicit?
    moderator?
  end

  def update_spoiler?
    moderator?
  end

  def update_ignore_reports?
    moderator?
  end

  def update_removed_reason?
    moderator?
  end

  def permitted_attributes_for_create
    [:title, :text, :url, :image, :explicit, :spoiler]
  end

  def permitted_attributes_for_update
    attributes = []
    attributes.push(:text) if update_text?
    attributes.push(:explicit) if update_explicit?
    attributes.push(:spoiler) if update_spoiler?
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
