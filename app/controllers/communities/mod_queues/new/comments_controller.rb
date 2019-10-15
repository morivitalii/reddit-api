# frozen_string_literal: true

class Communities::ModQueues::New::CommentsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(nil, policy_class: Community::ModQueue::New::CommentPolicy) }
  decorates_assigned :community, :comments

  def index
    @comments, @pagination = query.paginate(after: params[:after])
  end

  private

  def pundit_user
    Context.new(current_user, @community)
  end

  def query
    CommentsQuery.new(@community.comments).not_moderated.includes(:user, :post, :community)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end
end
