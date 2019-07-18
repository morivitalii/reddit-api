# frozen_string_literal: true

class LogsController < ApplicationController
  before_action :set_sub
  before_action -> { authorize(Log) }

  def index
    @records = Log.where(sub: @sub)
                   .includes(:user, :loggable)
                   .reverse_chronologically(params[:after].present? ? Log.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  private

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub].downcase).take! : nil
  end
end
