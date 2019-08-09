# frozen_string_literal: true

class Tag < ApplicationRecord
  include Paginatable

  LIMIT = 100

  belongs_to :sub, optional: true

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
    query_class = TagsQuery
    scope = query_class.new.global_or_sub(sub)
    scope = query_class.new(scope).filter_by_title(title)
    scope = scope.where.not(id: id) if persisted?
    scope.none?
  end

  def validate_limits
    if existent_count >= LIMIT
      errors.add(:title, :tags_limit)
    end
  end

  def existent_count
    query_class = TagsQuery
    scope = sub.present? ? query_class.new.sub(sub) : query_class.new.global
    scope.count
  end
end
