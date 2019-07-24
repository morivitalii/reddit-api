# frozen_string_literal: true

class ModQueuesController < ApplicationController
  layout "narrow"

  before_action :set_sub
  before_action -> { authorize(nil, policy_class: ModQueuePolicy) }

  def index
    scope = policy_scope(Thing, policy_scope_class: ModQueuePolicy::Scope)

    if @sub.present?
      scope = scope.where(sub: @sub)
    end

    @records = scope.where(deleted_at: nil, approved_at: nil).thing_type(type)
                   .reverse_chronologically(after)
                   .includes(:sub, :user, :post)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  private

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub]).take! : nil
  end

  def type
    ThingsTypes.new(params[:type]).key
  end

  def after
    params[:after].present? ? Thing.find_by_id(params[:after]) : nil
  end
end