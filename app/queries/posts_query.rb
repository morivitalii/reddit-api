# frozen_string_literal: true

class PostsQuery < ApplicationQuery
  def not_moderated
    relation.where(deleted_at: nil, approved_at: nil)
  end

  def reported
    relation.joins(:reports)
  end

  def created_after(datetime)
    relation.where("created_at > ?", datetime)
  end

  def search_created_after(datetime)
    return relation if datetime.blank?

    created_after(datetime)
  end
end