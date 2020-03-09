class Cleanup::StaleMutes
  def call
    MutesQuery.new.stale.in_batches.each_record(&:destroy)
  end
end
