# frozen_string_literal: true

class Rule < ApplicationRecord
  include Paginatable

  LIMIT = 15

  belongs_to :community, touch: true

  strip_attributes :title, :description, squish: true

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, allow_blank: true, length: { maximum: 500 }
  validate :validate_limits, on: :create

  private

  def validate_limits
    if existent_count >= LIMIT
      errors.add(:title, :rules_limit)
    end
  end

  def existent_count
    community.rules.count
  end
end
