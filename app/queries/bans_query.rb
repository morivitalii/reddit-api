class BansQuery < ApplicationQuery
  def stale
    relation.where("bans.end_at < ?", Time.current)
  end
end
