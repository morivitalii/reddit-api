# frozen_string_literal: true

class StaleLogsDeletion
  def call
    Log.where("created_at < ?", DataRetentionTime.logs).find_in_batches do |logs|
      BatchDeleteLogsJob.perform_later(logs.map(&:id))
    end
  end
end
