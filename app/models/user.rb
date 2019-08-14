# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_token :forgot_password_token

  has_many :follows, dependent: :destroy
  has_many :moderators, dependent: :destroy
  has_many :bans, dependent: :destroy
  has_many :posts, dependent: :restrict_with_error
  has_many :comments, dependent: :restrict_with_error
  has_many :bookmarks, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :rate_limits, dependent: :destroy

  validates :username, presence: true, username_format: true, uniqueness: { case_sensitive: false }
  validates :email, allow_blank: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,64})\z/i },
            uniqueness: { case_sensitive: false }

  def to_param
    username
  end
end
