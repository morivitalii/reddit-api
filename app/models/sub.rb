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

  strip_attributes :title, :description, squish: true

  validates :url, presence: true, length: { maximum: 20 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, allow_blank: true, length: { maximum: 200 }

  def to_param
    url
  end

  private

  def add_owner_as_moderator!
    moderators.create!(user: user, invited_by: user)
  end
end
