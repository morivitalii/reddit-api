class CommentSerializer < ApplicationSerializer
  def attributes
    {
      id: model.id,
      community: community,
      post: post,
      comment: comment,
      created_by: created_by,
      edited_by: edited_by,
      approved_by: approved_by,
      removed_by: removed_by,
      text: model.text,
      removed_reason: model.removed_reason,
      ignore_reports: model.ignore_reports,
      comments_count: model.comments_count,
      up_votes_count: model.up_votes_count,
      down_votes_count: model.down_votes_count,
      reports_count: model.reports_count,
      new_score: model.new_score,
      hot_score: model.hot_score,
      best_score: model.best_score,
      top_score: model.top_score,
      controversy_score: model.controversy_score,
      edited_at: model.edited_at,
      approved_at: model.approved_at,
      removed_at: model.removed_at,
      created_at: model.created_at,
      updated_at: model.updated_at,
    }
  end

  private

  def community
    model.association(:community).loaded? && model.community.present? ? CommunitySerializer.serialize(model.community) : nil
  end

  def post
    model.association(:post).loaded? && model.post.present? ? PostSerializer.serialize(model.post) : nil
  end

  def comment
    model.association(:comment).loaded? && model.comment.present? ? CommentSerializer.serialize(model.comment) : nil
  end

  def created_by
    model.association(:created_by).loaded? && model.created_by.present? ? UserSerializer.serialize(model.created_by) : nil
  end

  def edited_by
    model.association(:edited_by).loaded? && model.edited_by.present? ? UserSerializer.serialize(model.edited_by) : nil
  end

  def approved_by
    model.association(:approved_by).loaded? && model.approved_by.present? ? UserSerializer.serialize(model.approved_by) : nil
  end

  def removed_by
    model.association(:removed_by).loaded? && model.removed_by.present? ? UserSerializer.serialize(model.removed_by) : nil
  end
end
