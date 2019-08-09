# frozen_string_literal: true

module RateLimits
  extend ActiveSupport::Concern

  included do
    private

    def check_rate_limits(model, options)
      return true if skip_rate_limiting?

      attribute = options.fetch(:attribute)
      key = options.fetch(:key)
      limit = options.fetch(:limit)

      rate_limit = current_user_rate_limit(key)

      if rate_limit.hits > limit
        model.errors.add(attribute, :rate_limits)

        false
      else
        true
      end
    end

    def hit_rate_limits(options)
      return true if skip_rate_limiting?

      key = options.fetch(:key)

      rate_limit = current_user_rate_limit(key)
      rate_limit.increment!(:hits)
    end

    def current_user_rate_limit(key)
      scope = RateLimitsQuery.new.user_daily(current_user)
      @current_user_rate_limit ||= scope.find_or_create_by!(key: key)
    end

    def skip_rate_limiting?
      ApplicationPolicy.new(context, nil).skip_rate_limiting?
    end
  end
end