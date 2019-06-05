# frozen_string_literal: true

class Limits
  class << self
    def global_deletion_reasons
      50
    end

    def global_rules
      15
    end

    def sub_deletion_reasons
      50
    end

    def sub_rules
      15
    end

    def sub_tags
      100
    end

    def thing_reports
      100
    end
  end
end
