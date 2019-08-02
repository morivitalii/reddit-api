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
    scope = PostsQuery.new.not_moderated
    scope = PostsQuery.new(scope).where_sub(@sub)
    scope.includes(:user, :sub)
  end

  def comments_scope
    scope = CommentsQuery.new.not_moderated
    scope = CommentsQuery.new(scope).where_sub(@sub)
    scope.includes(:user, post: :sub)
  end

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = Sub.find_by_lower_url(params[:sub])
  end
end