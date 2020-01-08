class Api::Communities::Posts::Reports::IgnoreController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(Api::Communities::Posts::Reports::IgnorePolicy, @post) }

  def create
    Communities::IgnorePostReports.new(@post).call

    render json: {ignore_reports_link: post.ignore_reports_link}
  end

  def destroy
    Communities::DoNotIgnorePostReports.new(@post).call

    render json: {ignore_reports_link: post.ignore_reports_link}
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = @community.posts.find(params[:post_id])
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
