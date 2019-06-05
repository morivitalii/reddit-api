# frozen_string_literal: true

class DataRetentionTime
  class << self
    def temporary_files
      6.hours.ago
    end

    def rate_limits
      1.day.ago
    end

    def deleted_posts
      30.days.ago
    end

    def bans
      Time.current
    end

    def logs
      3.months.ago
    end

    def notifications
      3.months.ago
    end
  end
end
