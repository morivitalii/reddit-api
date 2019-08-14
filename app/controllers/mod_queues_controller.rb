# frozen_string_literal: true

class ModQueuesController < ApplicationController
  before_action :set_community
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
    Context.new(current_user, @community)
  end

  def posts_query
    PostsQuery.new(@community.posts).not_moderated.includes(:user, :community)
  end

  def comments_query
    CommentsQuery.new(@community.comments).not_moderated.includes(:user, :post, :community)
  end

  def set_facade
    @facade = ModQueuesFacade.new(context)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end
end