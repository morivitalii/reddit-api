# frozen_string_literal: true

class CreateBlacklistedDomain
  include ActiveModel::Model

  attr_accessor :current_user, :sub, :domain
  attr_reader :blacklisted_domain

  def save
    @blacklisted_domain = BlacklistedDomain.create!(
      sub: @sub,
      domain: @domain
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
