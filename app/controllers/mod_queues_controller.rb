# frozen_string_literal: true

class ModQueuesController < ApplicationController
  layout "narrow"

  before_action :set_sub
  before_action -> { authorize(nil, policy_class: ModQueuePolicy) }

  def index
    scope = policy_scope(Post, policy_scope_class: ModQueuePolicy::PostScope)

    @records, @pagination_record = scope.where(deleted_at: nil, approved_at: nil)
                                       .includes(:user, :sub)
                                       .paginate(after: params[:after])

    @records = @records.map(&:decorate)
  end

  def comments
    scope = policy_scope(Comment, policy_scope_class: ModQueuePolicy::CommentScope)

    @records, @pagination_record = scope.where(deleted_at: nil, approved_at: nil)
                                       .includes(:user, :post)
                                       .paginate(after: params[:after])

    @records = @records.map(&:decorate)
  end

  private

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = Sub.find_by_lower_url(params[:sub])
  end
end