# frozen_string_literal: true

module Cleanup
  class Logs
    def self.call
      older_than = 3.months.ago

      Log .where("created_at < ?", older_than).in_batches.each_record(&:destroy)
    end
  end
end
