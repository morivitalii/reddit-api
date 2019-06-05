# frozen_string_literal: true

class BatchDeleteLogs
  def initialize(ids:)
    @ids = ids
  end

  def call
    Log.where(id: @ids).delete_all
  end
end
