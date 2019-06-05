# frozen_string_literal: true

class DeletePost
  def initialize(post:)
    @post = post
  end

  def call
    @post.transaction do
      comments_ids = @post.comments.pluck(:id)
      ids = comments_ids + [@post.id]

      Notification.where(thing_id: ids).delete_all
      Bookmark.where(thing_id: ids).delete_all
      Vote.where(thing_id: ids).delete_all
      Report.where(thing_id: ids).delete_all
      ModQueue.where(thing_id: ids).delete_all
      Log.where(loggable_type: "Thing", loggable_id: ids).delete_all
      Topic.where(post: @post).delete_all
      Thing.where(id: comments_ids).delete_all
      @post.destroy
    end
  end
end
