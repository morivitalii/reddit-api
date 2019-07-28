# frozen_string_literal: true

module Votable
  extend ActiveSupport::Concern

  included do
    attribute :vote, default: nil

    has_many :votes, as: :votable

    private

    def create_self_up_vote!
      votes.create!(vote_type: :up, user: user)
    end
  end
end