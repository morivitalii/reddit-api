class Cleanup::StaleBans
  def call
    BansQuery.new.stale.in_batches.each_record(&:destroy)
  end
end
