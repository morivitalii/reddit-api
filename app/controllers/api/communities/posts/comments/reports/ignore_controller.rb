class Api::Communities::Posts::Comments::Reports::IgnoreController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action :set_comment
  before_action -> { authorize(Api::Communities::Posts::Comments::Reports::IgnorePolicy, @comment) }

  def create
    service = Communities::Posts::IgnoreCommentReports.new(comment: @comment)

    if service.call
      head :no_content
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    service = Communities::Posts::DoNotIgnoreCommentReports.new(comment: @comment)

    if service.call
      head :no_content
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = @community.posts.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:comment_id])
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
