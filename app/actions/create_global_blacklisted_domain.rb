# frozen_string_literal: true

class CreateGlobalBlacklistedDomain
  include ActiveModel::Model

  attr_accessor :current_user, :domain
  attr_reader :blacklisted_domain

  def save
    @blacklisted_domain = BlacklistedDomain.create!(
      domain: @domain
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      current_user: @current_user,
      action: "create_global_blacklisted_domain",
      model: @blacklisted_domain
    )
  end
end
