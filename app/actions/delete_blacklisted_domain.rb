# frozen_string_literal: true

class DeleteBlacklistedDomain
  def initialize(blacklisted_domain:, current_user:)
    @blacklisted_domain = blacklisted_domain
    @current_user = current_user
  end

  def call
    @blacklisted_domain.destroy!

    CreateLogJob.perform_later(
      current_user: @current_user,
      action: "delete_global_blacklisted_domain",
      loggable: @blacklisted_domain
    )
  end
end
