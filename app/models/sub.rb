# frozen_string_literal: true

class Sub < ApplicationRecord
  belongs_to :user
  has_many :follows, dependent: :destroy
  has_many :moderators, dependent: :destroy
  has_many :contributors, dependent: :destroy
  has_many :bans, dependent: :destroy
  has_many :posts, dependent: :restrict_with_error
  has_many :rules, dependent: :destroy
  has_many :deletion_reasons, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :pages, dependent: :destroy
  has_many :blacklisted_domains, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :url, presence: true, length: { maximum: 20 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, allow_blank: true, length: { maximum: 200 }

  def to_param
    url
  end

  def self.default
    self.where("lower(url) = ?", "all").take!
  end

  def self.find_by_lower_url(url = nil)
    url.present? ? self.where("lower(url) = ?", url.downcase).take! : nil
  end

  def title=(value)
    super(value&.squish)
  end

  def description=(value)
    super(value&.squish)
  end

  private

  def add_owner_as_moderator!
    moderators.create!(user: user, invited_by: user)
  end
end
