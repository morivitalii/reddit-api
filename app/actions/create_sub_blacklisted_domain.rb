# frozen_string_literal: true

class CreateSubBlacklistedDomain
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :domain
  attr_reader :blacklisted_domain

  def save!
    @blacklisted_domain = @sub.blacklisted_domains.create!(
      domain: @domain
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      action: "create_sub_blacklisted_domain",
      model: @blacklisted_domain
    )
  end
end
