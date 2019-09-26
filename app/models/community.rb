# frozen_string_literal: true

class Community < ApplicationRecord
  has_many :follows, dependent: :destroy
  has_many :moderators, dependent: :destroy
  has_many :bans, dependent: :destroy
  has_many :comments, dependent: :restrict_with_error
  has_many :posts, dependent: :restrict_with_error
  has_many :rules, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :url, presence: true, length: {maximum: 20}, uniqueness: true
  validates :title, presence: true, length: {maximum: 30}
  validates :description, allow_blank: true, length: {maximum: 200}

  def to_param
    url
  end
end
