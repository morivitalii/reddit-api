# frozen_string_literal: true

class DeleteBlacklistedDomainService
  attr_reader :blacklisted_domain

  def initialize(blacklisted_domain)
    @blacklisted_domain = blacklisted_domain
  end

  def call
    blacklisted_domain.destroy!
  end
end
