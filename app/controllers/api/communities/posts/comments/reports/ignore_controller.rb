class Api::Communities::Posts::Comments::Reports::IgnoreController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action :set_comment
  before_action -> { authorize(Api::Communities::Posts::Comments::Reports::IgnorePolicy, @comment) }

  def create
    Communities::Posts::IgnoreCommentReports.new(@comment).call

    render json: {ignore_reports_link: comment.ignore_reports_link}
  end

  def destroy
    Communities::Posts::DoNotIgnoreCommentReports.new(@comment).call

    render json: {ignore_reports_link: comment.ignore_reports_link}
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
