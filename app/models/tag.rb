# frozen_string_literal: true

class Tag < ApplicationRecord
  include Paginatable

  LIMIT = 100

  belongs_to :sub

  strip_attributes :title, squish: true

  validates :title, presence: true, length: { maximum: 30 }
  validate :validate_uniqueness
  validate :validate_limits, on: :create

  private

  def validate_uniqueness
    return if title.blank?

    unless unique?
      errors.add(:title, :taken)
    end
  end

  def unique?
    query = TagsQuery.new(sub.tags).with_title(title)
    query = query.where.not(id: id) if persisted?
    query.none?
  end

  def validate_limits
    if existent_count >= LIMIT
      errors.add(:title, :tags_limit)
    end
  end

  def existent_count
    sub.tags.count
  end
end
