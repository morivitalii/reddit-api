# frozen_string_literal: true

class DeletionReason < ApplicationRecord
  belongs_to :sub, optional: true

  scope :global, -> { where(sub: nil) }

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { maximum: 5_000 }
  validate :validate_limits, on: :create, if: ->(r) { r.errors.blank? }

  def title=(value)
    super(value.squish)
  end

  def description=(value)
    if value.present?
      super(value.squish)
    end
  end

  private

  def validate_limits
    if sub.present?
      if sub.deletion_reasons.count >= 50
        errors.add(:title, :deletion_reasons_limit)
      end
    else
      if DeletionReason.global.count >= 50
        errors.add(:title, :deletion_reasons_limit)
      end
    end
  end
end
