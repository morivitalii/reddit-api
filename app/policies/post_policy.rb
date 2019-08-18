# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user?
  end

  alias new? create?

  def update?
    author? || moderator?
  end

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

  def explicit?
    moderator?
  end

  def spoiler?
    moderator?
  end

  def ignore_reports?
    moderator?
  end

  def removed_reason?
    moderator?
  end

  def permitted_attributes_for_create
    [:title, :text, :url, :media, :explicit, :spoiler]
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
    attributes.push(:reason) if removed_reason?
    attributes
  end

  private

  def author?
    user? && user.id == record.user_id
  end
end
