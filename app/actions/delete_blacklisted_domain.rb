# frozen_string_literal: true

class DeleteBlacklistedDomain
  def initialize(blacklisted_domain:, current_user:)
    @blacklisted_domain = blacklisted_domain
    @current_user = current_user
  end

  def call
    @blacklisted_domain.destroy!

    CreateLogJob.perform_later(
      sub: @blacklisted_domain.sub,
      current_user: @current_user,
      action: "delete_blacklisted_domain",
      model: @blacklisted_domain
    )
  end
end
