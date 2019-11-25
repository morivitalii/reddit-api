class Moderator < ApplicationRecord
  include Paginatable

  belongs_to :community
  belongs_to :user

  validates :user, presence: true, uniqueness: {scope: :community_id}
end
