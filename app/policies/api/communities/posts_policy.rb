class Api::Communities::PostsPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user?
  end

  def update?
    author? && record.text?
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
