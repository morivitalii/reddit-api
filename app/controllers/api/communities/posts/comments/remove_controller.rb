class Api::Communities::Posts::Comments::RemoveController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action :set_comment
  before_action -> { authorize(Api::Communities::Posts::Comments::RemovePolicy, @comment) }

  def update
    service = Communities::Posts::RemoveComment.new(update_params)

    if service.call
      render json: CommentSerializer.serialize(service.comment)
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

  def update_params
    attributes = Api::Communities::Posts::Comments::RemovePolicy.new(pundit_user, @comment).permitted_attributes_for_update
    params.permit(attributes).merge(comment: @comment, user: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
