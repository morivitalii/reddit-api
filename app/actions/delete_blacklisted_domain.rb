# frozen_string_literal: true

class DeleteBlacklistedDomain
  def initialize(blacklisted_domain:, current_user:)
    @blacklisted_domain = blacklisted_domain
    @current_user = current_user
  end

  def call
    @blacklisted_domain.destroy!
  end
end
