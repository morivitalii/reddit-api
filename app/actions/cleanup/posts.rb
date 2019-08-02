# frozen_string_literal: true

module Cleanup
  class Posts
    # TODO rework
    def self.call
      # older_than = 30.days.ago
      #
      # Post.where("deleted_at < ?", older_than).find_each do |post|
      #   comments_ids = post.comments.pluck(:id)
      #   ids = comments_ids + [post.id]
      #
      #   Bookmark.where(bookmarkable_type: "Thing", bookmarkable_id: ids).delete_all
      #   Vote.where(thing_id: ids).delete_all
      #   Report.where(thing_id: ids).delete_all
      #   Topic.where(post: post).delete_all
      #   Comment.where(id: comments_ids).delete_all
      #   post.destroy
      # end
    end
  end
end
