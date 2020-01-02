class Api::Communities::Posts::Reports::IgnoreController < ApiApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(Api::Communities::Posts::Reports::IgnorePolicy, @post) }

  def create
    Communities::Posts::Reports::IgnoreService.new(@post).call

    render json: {ignore_reports_link: post.ignore_reports_link}
  end

  def destroy
    Communities::Posts::Reports::DoNotIgnoreService.new(@post).call

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
