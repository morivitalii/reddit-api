# frozen_string_literal: true

class BlacklistedDomain < ApplicationRecord
  include Paginatable

  belongs_to :sub, optional: true

  validates :domain, presence: true, length: { maximum: 253 }, format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/i }
  validate :validate_uniqueness

  private

  def validate_uniqueness
    scope = BlacklistedDomainsQuery.new.global_or_sub(sub)
    scope = BlacklistedDomainsQuery.new(scope).filter_by_domain(domain)

    if scope.exists?
      errors.add(:domain, :taken)
    end
  end
end
