# frozen_string_literal: true

class ReportsQuery < ApplicationQuery
  def recent(limit)
    relation.order(id: :desc).limit(limit)
  end
end