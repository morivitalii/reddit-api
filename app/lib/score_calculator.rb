# frozen_string_literal: true

class ScoreCalculator
  class << self
    def new_score(created_at)
      created_at.to_i
    end

    def best_score(up_votes, down_votes)
      z = 1.281551565545
      votes = up_votes + down_votes

      if votes.zero?
        return 0
      end

      p = 1 * up_votes / votes
      left = p + 1 / (2 * votes) * z * z
      right = z * Math.sqrt(p * (1 - p) / votes + z * z / (4 * votes * votes))
      under = 1 + 1 / votes * z * z

      (left - right) / under
    end

    def hot_score(up_votes, down_votes, created_at)
      score = up_votes - down_votes
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

    def top_score(up_votes, down_votes)
      up_votes - down_votes
    end

    def controversy_score(up_votes, down_votes)
      if up_votes <= 0 || down_votes <= 0
        return 0
      end

      magnitude = up_votes + down_votes
      balance = up_votes > down_votes ? down_votes / up_votes : up_votes / down_votes

      magnitude**balance
    end
  end
end