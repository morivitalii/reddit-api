class Cleanup::TempFiles
  def call
    older_than = 6.hours.ago

    Shrine.storages[:cache].clear!(older_than: older_than)
  end
end
