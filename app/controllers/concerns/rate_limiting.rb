module RateLimiting
  extend ActiveSupport::Concern

  included do
    private

    def validate_rate_limit(model, options)
      return true if skip_rate_limiting?

      attribute = options.fetch(:attribute)
      action = options.fetch(:action)
      limit = options.fetch(:limit)

      rate_limit = get_rate_limit(action)

      if rate_limit.hits >= limit
        model.errors.add(attribute, :rate_limit)

        false
      else
        true
      end
    end

    def hit_rate_limit(action)
      rate_limit = get_rate_limit(action)
      rate_limit.increment!(:hits)
    end

    protected

    def get_rate_limit(action)
      @get_rate_limit ||= RateLimitsQuery.new(current_user.rate_limits).daily.find_or_create_by!(action: action)
    end

    def skip_rate_limiting?
      ApplicationPolicy.new(pundit_user).skip_rate_limiting?
    end
  end
end
