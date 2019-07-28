# frozen_string_literal: true

module Cleanup
  class Posts
    def self.call
      older_than = 30.days.ago

      Thing.thing_type(:post).where("deleted_at < ?", older_than).find_each do |post|
        comments_ids = post.comments.pluck(:id)
        ids = comments_ids + [post.id]

        Notification.where(thing_id: ids).delete_all
        Bookmark.where(bookmarkable_type: "Thing", bookmarkable_id: ids).delete_all
        Vote.where(thing_id: ids).delete_all
        Report.where(thing_id: ids).delete_all
        Topic.where(post: post).delete_all
        Thing.where(id: comments_ids).delete_all
        post.destroy
      end
    end
  end
end
