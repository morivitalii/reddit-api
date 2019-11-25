class Communities::Posts::RemoveController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(@post, policy_class: Communities::Posts::RemovePolicy) }
  decorates_assigned :post

  def edit
    @form = Communities::Posts::RemoveForm.new(reason: @post.removed_reason)

    render partial: "edit"
  end

  def update
    @form = Communities::Posts::RemoveForm.new(update_params)

    if @form.save
      render json: {approve_link: post.approve_link, remove_link: post.remove_link}
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

  def update_params
    attributes = Communities::Posts::RemovePolicy.new(pundit_user, @post).permitted_attributes_for_update
    params.require(:communities_posts_remove_form).permit(attributes).merge(post: @post, user: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
