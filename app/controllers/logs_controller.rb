# frozen_string_literal: true

class LogsController < ApplicationController
  before_action :set_sub
  before_action -> { authorize(@sub, policy_class: LogPolicy) }

  def index
    @records = Log.include(ReverseChronological)
                   .where(sub: @sub)
                   .includes(:user, :loggable)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? Log.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  private

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub].downcase).take! : nil
  end
end
