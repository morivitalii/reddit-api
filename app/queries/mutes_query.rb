class MutesQuery < ApplicationQuery
  def stale
    relation.where("mutes.end_at < ?", Time.current)
  end
end
