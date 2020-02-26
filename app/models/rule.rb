class Rule < ApplicationRecord
  LIMIT = 15

  belongs_to :community

  validates :title, presence: true, length: {maximum: 100}
  validates :description, allow_blank: true, length: {maximum: 500}
  validate :validate_limits, on: :create

  private

  def validate_limits
    if community.rules.count >= LIMIT
      errors.add(:title, :limit, count: LIMIT)
    end
  end
end
