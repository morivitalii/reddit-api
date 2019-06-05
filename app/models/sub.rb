# frozen_string_literal: true

class Sub < ApplicationRecord
  belongs_to :user
  has_many :follows
  has_many :moderators
  has_many :contributors
  has_many :bans
  has_many :things
  has_many :rules
  has_many :deletion_reasons
  has_many :tags
  has_many :logs
  has_many :pages
  has_many :blacklisted_domains
  has_many :mod_queues

  after_create :add_creator_as_master_moderator

  validates :url, presence: true, length: { maximum: 20 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, allow_blank: true, length: { maximum: 200 }

  def to_param
    url
  end

  def title=(value)
    super(value&.squish)
  end

  def description=(value)
    super(value&.squish)
  end

  private

  def add_creator_as_master_moderator
    moderators.create!(user: user, invited_by: user, master: true)
  end
end
