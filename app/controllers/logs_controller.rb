# frozen_string_literal: true

class LogsController < ApplicationController
  def index
    LogsPolicy.authorize!(:index)

    @records = Log.include(ReverseChronologicalOrder)
                   .global
                   .includes(:user, :loggable)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? Log.global.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.logs + 1)
                   .to_a

    if @records.size > PaginationLimits.logs
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end
end
