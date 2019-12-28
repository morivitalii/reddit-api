class Api::Communities::Posts::BookmarksController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(@post, policy_class: Api::Communities::Posts::BookmarksPolicy) }

  def create
    @post.bookmark = Communities::Posts::CreateBookmarkService.new(@post, current_user).call

    render json: {bookmark_link: post.bookmark_link}
  end

  def destroy
    Communities::Posts::DeleteBookmarkService.new(@post, current_user).call

    render json: {bookmark_link: post.bookmark_link}
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
