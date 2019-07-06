# frozen_string_literal: true

class LogsController < ApplicationController
  before_action -> { authorize(Log, policy_class: LogPolicy) }

  def index
    @records = Log.include(ReverseChronologicalOrder)
                   .global
                   .includes(:user, :loggable)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? Log.global.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end
end
