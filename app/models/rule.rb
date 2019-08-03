# frozen_string_literal: true

class Rule < ApplicationRecord
  include Paginatable

  belongs_to :sub, optional: true

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, allow_blank: true, length: { maximum: 500 }
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
      if sub.rules.count >= 15
        errors.add(:title, :rules_limit)
      end
    else
      if RulesQuery.new.where_global.count >= 15
        errors.add(:title, :rules_limit)
      end
    end
  end
end
