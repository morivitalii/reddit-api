class Mute < ApplicationRecord
  belongs_to :community
  belongs_to :user

  before_save :set_end_at

  validates :user, presence: true, uniqueness: {scope: :community_id}
  validates :reason, allow_blank: true, length: {maximum: 500}
  validates :days, absence: true, if: ->(r) { r.permanent }
  validates :days, presence: true,
                   numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 365},
                   unless: ->(r) { r.permanent }

  private

  def set_end_at
    self.created_at ||= Time.current
    self.end_at = permanent? ? nil : created_at + days.days
  end
end
