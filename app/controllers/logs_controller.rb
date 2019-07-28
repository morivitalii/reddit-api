# frozen_string_literal: true

class LogsController < ApplicationController
  before_action :set_sub
  before_action -> { authorize(Log) }

  def index
    @records, @pagination_record = Log.where(sub: @sub).includes(:user, :loggable).paginate(after: params[:after])
  end

  private

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = Sub.find_by_lower_url(params[:sub])
  end
end
