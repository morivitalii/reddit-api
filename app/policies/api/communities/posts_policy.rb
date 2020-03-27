class Api::Communities::PostsPolicy < ApplicationPolicy
  def show?
    !banned?
  end

  def create?
    user? && !muted? && !banned?
  end

  def update?
    author? && !muted? && !banned? && record.text?
  end

  def permitted_attributes_for_create
    [:title, :text, :file, :explicit, :spoiler]
  end

  def permitted_attributes_for_update
    attributes = []
    attributes.push(:text) if update?
    attributes
  end

  private

  def author?
    user? && user.id == record.created_by_id
  end
end
