class Community < ApplicationRecord
  has_many :follows, as: :followable, dependent: :destroy
  has_many :moderators, dependent: :destroy
  has_many :bans, as: :source, dependent: :destroy
  has_many :mutes, dependent: :destroy
  has_many :comments, dependent: :restrict_with_error
  has_many :posts, dependent: :restrict_with_error
  has_many :rules, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :url, presence: true,
                  format: {with: /\A[a-z0-9_-]{2,30}\z/i},
                  uniqueness: {case_sensitive: false}

  validates :title, presence: true, length: {maximum: 30}
  validates :description, allow_blank: true, length: {maximum: 200}

  def to_param
    url
  end
end
