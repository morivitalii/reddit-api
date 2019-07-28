# frozen_string_literal: true

class BlacklistedDomain < ApplicationRecord
  include Paginatable

  belongs_to :sub, optional: true

  scope :global, -> { where(sub: nil) }

  before_validation :preserve_only_upper_domain_zone

  validates :domain, presence: true, length: { maximum: 253 }

  with_options if: ->(r) { r.errors.blank? } do
    validates :domain, format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/i }
    validate :validate_uniqueness, if: ->(record) { record.errors.blank? }
  end

  def self.search(query)
    where("lower(domain) = ?", query)
  end

  private

  def preserve_only_upper_domain_zone
    if domain.present?
      self.domain = domain.split(".").last(2).join(".")
    end
  end

  def validate_uniqueness
    if self.class.where(sub: sub).where("lower(domain) = ?", domain.downcase).exists?
      errors.add(:domain, :taken)
    end
  end
end
