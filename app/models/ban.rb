# frozen_string_literal: true

class Ban < ApplicationRecord
  include Paginatable

  belongs_to :sub, optional: true
  belongs_to :user
  belongs_to :banned_by, class_name: "User", foreign_key: "banned_by_id"

  scope :global, -> { where(sub: nil) }

  before_create :delete_user_as_contributor_on_create
  before_save :set_end_at_on_save

  validates :reason, allow_blank: true, length: { maximum: 500 }
  validates :days, absence: true, if: ->(record) { record.permanent }
  validates :days, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 365 }, if: ->(record) { !record.permanent }

  def reason=(value)
    super(value&.squish)
  end

  def stale?
    return false if permanent?

    end_at < Time.current
  end

  def self.search(query)
    joins(:user).where("lower(users.username) = ?", query)
  end

  private

  def delete_user_as_contributor_on_create
    user.contributors.where(sub: sub).destroy_all
  end

  def set_end_at_on_save
    if permanent?
      self.end_at = nil
    else
      self.end_at = (created_at.presence || Time.current) + days.days
    end
  end
end
