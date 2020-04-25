class Tag < ApplicationRecord
  belongs_to :community

  validates :text, presence: true, length: {maximum: 50}, uniqueness: { case_sensitive: false, scope: [:community_id] }
end