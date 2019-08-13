# frozen_string_literal: true

class ModQueuesController < ApplicationController
  before_action :set_sub
  before_action :set_facade
  before_action -> { authorize(:mod_queue) }

  def posts
    @records, @pagination = posts_query.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  def comments
    @records, @pagination = comments_query.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def posts_query
    PostsQuery.new(@sub.posts).not_moderated.includes(:user, :sub)
  end

  def comments_query
    CommentsQuery.new(@sub.comments).not_moderated.includes(:user, :post, :sub)
  end

  def set_facade
    @facade = ModQueuesFacade.new(context)
  end

  def set_sub
    @sub = SubsQuery.new.with_url(params[:sub_id]).take!
  end
end