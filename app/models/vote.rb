class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  enum vote_type: {up: 1, down: -1}

  validates :user, uniqueness: {scope: [:votable_type, :votable_id]}
  validates :vote_type, presence: true
end
