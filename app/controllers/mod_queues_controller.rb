# frozen_string_literal: true

class ModQueuesController < ApplicationController
  layout "narrow"

  before_action :set_sub
  before_action -> { authorize(:mod_queue) }

  def index
    scope = policy_scope(posts_scope, policy_scope_class: ModQueuePolicy::PostScope)

    @records, @pagination_record = scope.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  def comments
    scope = policy_scope(comments_scope, policy_scope_class: ModQueuePolicy::CommentScope)

    @records, @pagination_record = scope.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  private

  def posts_scope
    query_class = PostsQuery

    scope = query_class.new.not_moderated
    scope = query_class.new(scope).where_sub(@sub)
    scope.includes(:user, :sub)
  end

  def comments_scope
    query_class = CommentsQuery

    scope = query_class.new.not_moderated
    scope = query_class.new(scope).where_sub(@sub)
    scope.includes(:user, post: :sub)
  end

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    if params[:sub].present?
      @sub = SubsQuery.new.where_url(params[:sub]).take!
    end
  end
end