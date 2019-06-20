# frozen_string_literal: true

module Cleanup
  class Bans
    def self.call
      older_than = Time.current

      Ban.where("end_at < ?", older_than).in_batches.each_record(&:destroy)
    end
  end
end
