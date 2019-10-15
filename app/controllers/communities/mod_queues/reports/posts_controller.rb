# frozen_string_literal: true

class Communities::ModQueues::Reports::PostsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(nil, policy_class: Community::ModQueue::Report::PostPolicy) }
  decorates_assigned :community, :posts

  def index
    @posts, @pagination = query.paginate(after: params[:after])
  end

  private

  def pundit_user
    Context.new(current_user, @community)
  end

  def query
    PostsQuery.new(@community.posts).reported.includes(:community, :user)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end
end
