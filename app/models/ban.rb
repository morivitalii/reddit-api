# frozen_string_literal: true

class Ban < ApplicationRecord
  include Paginatable

  belongs_to :community, touch: true
  belongs_to :user, touch: true

  strip_attributes :reason, squish: true

  before_save :set_end_at

  validates :user, presence: { message: :invalid_username }, uniqueness: { scope: :community_id }
  validates :reason, allow_blank: true, length: { maximum: 500 }
  validates :days, absence: true, if: -> (r) { r.permanent }
  validates :days, presence: true,
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 365 },
            unless: -> (r) { r.permanent }

  private

  def set_end_at
    self.created_at ||= Time.current
    self.end_at = permanent? ? nil : created_at + days.days
  end
end
