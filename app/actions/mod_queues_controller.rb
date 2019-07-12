# frozen_string_literal: true

class ModQueuesController < ApplicationController
  layout "narrow"

  before_action :set_sub
  before_action -> { authorize(ModQueue) }
  before_action :set_navigation_title

  def index
    scope = policy_scope(ModQueue)

    if @sub.present?
      scope = scope.where(sub: @sub)
    end

    @records = scope.queue_type(helpers.mod_queue_filter(params[:mod_queue_type]))
                   .thing_type(ThingsTypes.new(params[:thing_type]).key)
                   .reverse_chronologically(params[:after].present? ? ModQueue.find_by_id(params[:after]) : nil)
                   .includes(thing: [:sub, :user, :post])
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:thing)
  end

  private

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub]).take! : nil
  end

  def set_navigation_title
    @navigation_title = t("mod_queue")
  end
end