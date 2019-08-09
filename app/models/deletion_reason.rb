# frozen_string_literal: true

class DeletionReason < ApplicationRecord
  include Paginatable

  LIMIT = 50

  belongs_to :sub, optional: true

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { maximum: 5_000 }
  validate :validate_limits, on: :create

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
    if existent_count >= LIMIT
      errors.add(:title, :deletion_reasons_limit)
    end
  end

  def existent_count
    query_class = DeletionReasonsQuery
    scope = sub.present? ? query_class.new.sub(sub) : query_class.new.global
    scope.count
  end
end
