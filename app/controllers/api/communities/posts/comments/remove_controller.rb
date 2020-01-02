class Api::Communities::Posts::Comments::RemoveController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action :set_comment
  before_action -> { authorize(Api::Communities::Posts::Comments::RemovePolicy, @comment) }

  def edit
    @form = Communities::Posts::Comments::RemoveForm.new(reason: @comment.removed_reason)

    render partial: "edit"
  end

  def update
    @form = Communities::Posts::Comments::RemoveForm.new(update_params)

    if @form.save
      render json: {approve_link: comment.approve_link, remove_link: comment.remove_link}
    else
      render json: @form.errors, status: :unprocessable_entity
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
    params.require(:communities_posts_comments_remove_form).permit(attributes).merge(comment: @comment, user: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
