# frozen_string_literal: true

class CreateBlacklistedDomain
  include ActiveModel::Model

  attr_accessor :current_user, :sub, :domain
  attr_reader :blacklisted_domain

  def save
    ActiveRecord::Base.transaction do
      @blacklisted_domain = BlacklistedDomain.create!(
        sub: @sub,
        domain: @domain
      )

      CreateLog.new(
        sub: @sub,
        current_user: @current_user,
        action: :create_blacklisted_domain,
        attributes: [:domain],
        model: @blacklisted_domain
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
