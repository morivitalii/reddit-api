# frozen_string_literal: true

module Cleanup
  class Posts
    def self.call
      older_than = 30.days.ago

      Thing.thing_type(:post).where("deleted_at < ?", older_than).find_each do |post|
        DeletePost.new(post: post).call
      end
    end
  end
end
