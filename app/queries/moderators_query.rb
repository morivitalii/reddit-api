class ModeratorsQuery < ApplicationQuery
  def recent(limit)
    relation.order(id: :asc).limit(limit)
  end
end
