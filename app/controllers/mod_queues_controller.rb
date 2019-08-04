# frozen_string_literal: true

class ModQueuesController < ApplicationController
  before_action :set_sub
  before_action :set_facade
  before_action -> { authorize(:mod_queue) }

  def index
    @records, @pagination = posts_scope.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  def comments
    @records, @pagination = comments_scope.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def posts_scope
    query_class = PostsQuery
    scope = query_class.new.not_moderated
    scope = query_class.new(scope).filter_by_sub(@sub)
    scope = policy_scope(scope, policy_scope_class: ModQueuePolicy::PostScope)
    scope.includes(:user, :sub)
  end

  def comments_scope
    query_class = CommentsQuery
    scope = query_class.new.not_moderated
    scope = query_class.new(scope).filter_by_sub(@sub)
    scope = policy_scope(scope, policy_scope_class: ModQueuePolicy::CommentScope)
    scope.includes(:user, post: :sub)
  end

  def set_facade
    @facade = ModQueuesFacade.new(context)
  end

  def set_sub
    if params[:sub].present?
      @sub = SubsQuery.new.where_url(params[:sub]).take!
    end
  end
end