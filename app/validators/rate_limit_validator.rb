# frozen_string_literal: true

class RateLimitValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if RateLimit.beyond?(options[:key].call(record), options[:sub].call(record))
      record.errors.add(attribute, :beyond_rate_limits)
    end
  end
end
