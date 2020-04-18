class PostsQuery < ApplicationQuery
  def not_moderated
    relation.where(removed_at: nil, approved_at: nil)
  end

  def not_removed
    relation.where(removed_at: nil)
  end

  def reported
    relation.joins(:reports).distinct
  end

  def for_the_last_day
    relation.where("posts.created_at > ?", 1.day.ago)
  end

  def for_the_last_week
    relation.where("posts.created_at > ?", 1.week.ago)
  end

  def for_the_last_month
    relation.where("posts.created_at > ?", 1.month.ago)
  end
end
