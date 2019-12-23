class Api::Communities::Posts::Comments::BookmarksController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action :set_comment
  before_action -> { authorize(@comment, policy_class: Api::Communities::Posts::Comments::BookmarksPolicy) }
  decorates_assigned :comment

  def create
    @comment.bookmark = Communities::Posts::Comments::CreateBookmarkService.new(@comment, current_user).call

    render json: {bookmark_link: comment.bookmark_link}
  end

  def destroy
    Communities::Posts::Comments::DeleteBookmarkService.new(@comment, current_user).call

    render json: {bookmark_link: comment.bookmark_link}
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
