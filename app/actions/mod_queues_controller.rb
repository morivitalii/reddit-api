# frozen_string_literal: true

class ModQueuesController < ApplicationController
  layout "narrow"

  before_action :set_sub
  before_action -> { authorize(ModQueue) }
  before_action :set_navigation_title

  def index
    scope = policy_scope(ModQueue)

    if @sub.present?
      scope = scope.where(things: { sub: @sub })
    end

    @records = scope.queue_type(mod_queue_type)
                   .merge(Thing.thing_type(thing_type))
                   .reverse_chronologically(after)
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

  def mod_queue_type
    ModQueuesTypes.new(params[:mod_queue_type]).key
  end

  def thing_type
    ThingsTypes.new(params[:thing_type]).key
  end

  def after
    params[:after].present? ? ModQueue.find_by_id(params[:after]) : nil
  end
end