# frozen_string_literal: true

class ModQueuesController < ApplicationController
  before_action :set_community
  before_action -> { authorize(:mod_queue) }

  def new_posts
    @records, @pagination = new_posts_query.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  def new_comments
    @records, @pagination = new_comments_query.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  def reported_posts
    @records, @pagination = reported_posts_query.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  def reported_comments
    @records, @pagination = reported_comments_query.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  private

  def pundit_user
    Context.new(current_user, @community)
  end

  def new_posts_query
    PostsQuery.new(@community.posts).not_moderated.includes(:user, :community)
  end

  def new_comments_query
    CommentsQuery.new(@community.comments).not_moderated.includes(:user, :post, :community)
  end

  def reported_posts_query
    PostsQuery.new(@community.posts).reported.includes(:community, :user)
  end

  def reported_comments_query
    CommentsQuery.new(@community.comments).reported.includes(:user, :post, :community)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end
end