# frozen_string_literal: true

class TagsQuery < ApplicationQuery
  def with_title(title)
    relation.where("lower(title) = ?", title.downcase)
  end
end