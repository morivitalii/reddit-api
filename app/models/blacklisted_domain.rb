# frozen_string_literal: true

class BlacklistedDomain < ApplicationRecord
  include Paginatable

  belongs_to :sub

  validates :domain, presence: true, length: { maximum: 253 }, format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/i }
  validate :validate_uniqueness

  private

  def validate_uniqueness
    return if domain.blank?

    unless unique?
      errors.add(:domain, :taken)
    end
  end

  def unique?
    BlacklistedDomainsQuery.new(sub.blacklisted_domains).with_domain(domain).none?
  end
end
