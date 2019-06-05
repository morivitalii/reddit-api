# frozen_string_literal: true

class BatchDeleteLogsJob < ApplicationJob
  queue_as :low_priority

  def perform(ids)
    BatchDeleteLogs.new(ids: ids).call
  end
end
