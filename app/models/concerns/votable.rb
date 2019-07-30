# frozen_string_literal: true

module Votable
  extend ActiveSupport::Concern

  included do
    attribute :vote, default: nil

    has_many :votes, as: :votable, dependent: :destroy

    alias_attribute :score, :top_score

    def create_self_up_vote!
      votes.create!(vote_type: :up, user: user)
    end

    def update_scores!
      update!(
        new_score: calculate_new_score,
        hot_score: calculate_hot_score,
        best_score: calculate_best_score,
        top_score: calculate_top_score,
        controversy_score: calculate_controversy_score,
      )
    end

    def votable?
      true
    end

    private

    def calculate_new_score
      created_at.to_i
    end

    def calculate_best_score
      z = 1.281551565545
      votes = up_votes_count + down_votes_count

      if votes.zero?
        return 0
      end

      p = 1 * up_votes_count / votes
      left = p + 1 / (2 * votes) * z * z
      right = z * Math.sqrt(p * (1 - p) / votes + z * z / (4 * votes * votes))
      under = 1 + 1 / votes * z * z

      (left - right) / under
    end

    def calculate_hot_score
      score = up_votes_count - down_votes_count
      order = Math.log10([score.abs, 1].max)

      sign = if score.positive?
               1
             elsif score.negative?
               -1
             else
               0
             end

      seconds = created_at.to_i - 1509818664

      (order + ((sign * seconds) / 45_000)).round(7)
    end

    def calculate_top_score
      up_votes_count - down_votes_count
    end

    def calculate_controversy_score
      if up_votes_count <= 0 || down_votes_count <= 0
        return 0
      end

      magnitude = up_votes_count + down_votes_count
      balance = up_votes_count > down_votes_count ? down_votes_count / up_votes_count : up_votes_count / down_votes_count

      magnitude**balance
    end
  end
end