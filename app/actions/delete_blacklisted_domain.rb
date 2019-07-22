# frozen_string_literal: true

class DeleteBlacklistedDomain
  def initialize(blacklisted_domain:, current_user:)
    @blacklisted_domain = blacklisted_domain
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @blacklisted_domain.destroy!

      CreateLog.new(
        sub: @blacklisted_domain.sub,
        current_user: @current_user,
        action: :delete_blacklisted_domain,
        attributes: [:domain],
        model: @blacklisted_domain
      ).call
    end
  end
end
