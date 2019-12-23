class Api::Communities::PostsPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user?
  end

  alias new_text? create?
  alias new_link? create?
  alias new_image? create?

  def edit?
    author? && record.text?
  end

  alias update? edit?

  def permitted_attributes_for_create
    [:title, :text, :url, :image, :explicit, :spoiler]
  end

  def permitted_attributes_for_update
    attributes = []
    attributes.push(:text) if update?
    attributes
  end

  private

  def author?
    user? && user.id == record.user_id
  end
end
