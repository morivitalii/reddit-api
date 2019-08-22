# frozen_string_literal: true

class Moderator < ApplicationRecord
  include Paginatable

  belongs_to :community
  belongs_to :user

  validates :user, presence: { message: :invalid_username }, uniqueness: { scope: :community_id }
end
