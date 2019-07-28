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

    @records, @pagination_record = scope.where(deleted_at: nil, approved_at: nil)
                                       .thing_type(type)
                                       .includes(:sub, :user, :post)
                                       .paginate(after: params[:after])
  end

  private

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub]).take! : nil
  end

  def type
    ThingsTypes.new(params[:type]).key
  end
end