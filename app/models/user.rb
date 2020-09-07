class User < ApplicationRecord
  has_secure_password
  has_secure_token :forgot_password_token

  has_one :admin, dependent: :destroy
  has_one :exile, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :moderators, dependent: :destroy
  has_many :bans, as: :target, dependent: :destroy
  has_many :mutes, as: :target, dependent: :destroy
  has_many :posts, foreign_key: "created_by_id", dependent: :restrict_with_error
  has_many :comments, foreign_key: "created_by_id", dependent: :restrict_with_error
  has_many :bookmarks, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :rate_limits, dependent: :destroy

  validates :username, presence: true,
                       format: {with: /\A[a-z0-9_-]{2,16}\z/i},
                       uniqueness: {case_sensitive: false}

  validates :email, allow_blank: true,
                    format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,64})\z/i},
                    uniqueness: {case_sensitive: false}

  def to_param
    username
  end
end
