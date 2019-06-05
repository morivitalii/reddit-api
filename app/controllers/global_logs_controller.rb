# frozen_string_literal: true

class GlobalLogsController < ApplicationController
  def index
    GlobalLogsPolicy.authorize!(:index)

    @records = Log.include(ReverseChronologicalOrder)
                   .global
                   .includes(:user, :loggable)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? Log.global.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.global_logs + 1)
                   .to_a

    if @records.size > PaginationLimits.global_logs
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end
end
