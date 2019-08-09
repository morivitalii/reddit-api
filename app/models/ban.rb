# frozen_string_literal: true

class Ban < ApplicationRecord
  include Paginatable

  belongs_to :sub, optional: true
  belongs_to :user
  belongs_to :banned_by, class_name: "User", foreign_key: "banned_by_id"

  strip_attributes :reason, squish: true

  before_save :set_end_at_on_save

  validates :reason, allow_blank: true, length: { maximum: 500 }
  validates :days, absence: true, if: ->(record) { record.permanent }
  validates :days, presence: true,
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 365 },
            if: ->(record) { !record.permanent }

  def stale?
    permanent? ? false : end_at < Time.current
  end

  private

  def set_end_at_on_save
    self.created_at ||= Time.current
    self.end_at = permanent? ? nil : created_at + days.days
  end
end
