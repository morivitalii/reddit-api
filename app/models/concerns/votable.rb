# frozen_string_literal: true

module Votable
  extend ActiveSupport::Concern

  included do
    attribute :vote, default: nil

    has_many :votes

    after_create :create_up_vote_on_create

    private

    def create_up_vote_on_create
      votes.create!(vote_type: :up, user: user)
    end
  end
end