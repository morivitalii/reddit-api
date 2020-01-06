class Api::Communities::ModQueues::Reports::CommentsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::ModQueues::Reports::CommentsPolicy) }

  def index
    @comments, @pagination = query.paginate(
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after]
    )
  end

  private

  def query
    CommentsQuery.new(@community.comments).reported.includes(:user, :post, :community)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
