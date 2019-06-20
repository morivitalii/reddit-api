# frozen_string_literal: true

module Cleanup
  class TempFiles
    def self.call
      older_than = 6.hours.ago

      Shrine.storages[:cache].clear!(older_than: older_than)
    end
  end
end