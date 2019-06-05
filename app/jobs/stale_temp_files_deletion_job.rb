# frozen_string_literal: true

class StaleTempFilesDeletionJob < ApplicationJob
  queue_as :high_priority

  def perform
    Shrine.storages[:cache].clear!(older_than: DataRetentionTime.temporary_files)
  end
end
