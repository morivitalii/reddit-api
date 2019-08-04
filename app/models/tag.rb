# frozen_string_literal: true

class Tag < ApplicationRecord
  include Paginatable

  belongs_to :sub, optional: true

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
    query_class = TagsQuery
    scope = query_class.new.global_or_sub(sub)
    scope = query_class.new(scope).filter_by_title(title.squish)

    if persisted?
      scope = scope.where.not(id: id)

      if scope.exists?
        errors.add(:title, :taken)
      end
    else
      if scope.exists?
        errors.add(:title, :taken)
      end
    end
  end

  def validate_limits
    if sub.present?
      if sub.deletion_reasons.count >= 100
        errors.add(:title, :tags_limit)
      end
    else
      if TagsQuery.new.global.count >= 100
        errors.add(:title, :tags_limit)
      end
    end
  end
end
