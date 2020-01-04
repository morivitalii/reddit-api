class PostsQuery < ApplicationQuery
  def not_moderated
    relation.where(removed_at: nil, approved_at: nil)
  end

  def not_removed
    relation.where(removed_at: nil)
  end

  def reported
    relation.joins(:reports)
  end

  def for_the_last_day
    relation.where("posts.created_at > ?", 1.day.ago)
  end

  def created_after(datetime)
    relation.where("posts.created_at > ?", datetime)
  end

  def search_created_after(datetime)
    return relation if datetime.blank?

    created_after(datetime)
  end

  def bookmarked_by_user(user)
    relation.joins(:bookmarks).where(bookmarks: {user: user}).order("bookmarks.id desc")
  end

  def voted_by_user(user)
    relation.joins(:votes).where(votes: {user: user}).order("votes.id desc")
  end

  def up_voted_by_user(user)
    relation.joins(:votes).where(votes: {user: user, vote_type: :up}).order("votes.id desc")
  end

  def down_voted_by_user(user)
    relation.joins(:votes).where(votes: {user: user, vote_type: :down}).order("votes.id desc")
  end
end
