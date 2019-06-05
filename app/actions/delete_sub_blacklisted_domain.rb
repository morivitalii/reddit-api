# frozen_string_literal: true

class DeleteSubBlacklistedDomain
  def initialize(blacklisted_domain:, current_user:)
    @blacklisted_domain = blacklisted_domain
    @current_user = current_user
  end

  def call
    @blacklisted_domain.destroy!

    CreateLogJob.perform_later(
      sub: @blacklisted_domain.sub,
      current_user: @current_user,
      action: "delete_sub_blacklisted_domain",
      loggable: @blacklisted_domain
    )
  end
end
