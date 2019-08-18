# frozen_string_literal: true

class Moderator < ApplicationRecord
  include Paginatable

  belongs_to :community, touch: true
  belongs_to :user, touch: true

  validates :user, presence: { message: :invalid_username }, uniqueness: { scope: :community_id }
end
