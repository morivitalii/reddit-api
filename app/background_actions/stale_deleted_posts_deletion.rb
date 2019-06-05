# frozen_string_literal: true

class StaleDeletedPostsDeletion
  def call
    Thing.thing_type(:post).where("deleted_at < ?", DataRetentionTime.deleted_posts).find_each do |thing|
      DeletePostJob.perform_later(thing.id)
    end
  end
end
