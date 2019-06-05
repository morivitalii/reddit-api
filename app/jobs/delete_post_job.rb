# frozen_string_literal: true

class DeletePostJob < ApplicationJob
  queue_as :low_priority

  def perform(id)
    DeletePost.new(post: Thing.thing_type(:post).find(id)).call
  end
end
