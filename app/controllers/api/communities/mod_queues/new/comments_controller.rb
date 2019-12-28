class Api::Communities::ModQueues::New::CommentsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::ModQueues::New::CommentsPolicy) }

  def index
    @comments, @pagination = query.paginate(after: params[:after])
  end

  private

  def query
    CommentsQuery.new(@community.comments).not_moderated.includes(:user, :post, :community)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
