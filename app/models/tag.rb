# frozen_string_literal: true

class Tag < ApplicationRecord
  belongs_to :sub

  validates :title, presence: true, length: { maximum: 30 }

  with_options if: ->(r) { r.errors.blank? } do
    validate :validate_uniqueness
    validate :validate_limits, on: :create
  end

  def title=(value)
    super(value.squish)
  end

  private

  def validate_uniqueness
    if persisted?
      if sub.tags.where.not(id: id).where("lower(tags.title) = ?", title.squish.downcase).exists?
        errors.add(:title, :taken)
      end
    else
      if sub.tags.where("lower(tags.title) = ?", title.squish.downcase).exists?
        errors.add(:title, :taken)
      end
    end
  end

  def validate_limits
    if sub.tags.count >= 100
      errors.add(:title, :tags_limit)
    end
  end
end
