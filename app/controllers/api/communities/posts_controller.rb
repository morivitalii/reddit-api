class Api::Communities::PostsController < ApplicationController
  before_action :set_community
  before_action :set_post, only: [:show, :edit, :update]
  before_action -> { authorize(nil, policy_class: Api::Communities::PostsPolicy) }, only: [:new_text, :new_link, :new_image, :create]
  before_action -> { authorize(@post, policy_class: Api::Communities::PostsPolicy) }, only: [:show, :edit, :update]
  decorates_assigned :community, :post

  def show
  end

  def new_text
    @form = Communities::Posts::CreateForm.new
  end

  def new_link
    @form = Communities::Posts::CreateForm.new
  end

  def new_image
    @form = Communities::Posts::CreateForm.new
  end

  def edit
    attributes = @post.slice(:text)

    @form = Communities::Posts::UpdateForm.new(attributes)
  end

  def create
    @form = Communities::Posts::CreateForm.new(create_params)

    rate_limit_action = :create_post
    rate_limit = 100

    if validate_rate_limit(@form, attribute: :title, action: rate_limit_action, limit: rate_limit) && @form.save
      hit_rate_limit(rate_limit_action)

      head :no_content, location: community_post_path(@form.post.community, @form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = Communities::Posts::UpdateForm.new(update_params)

    if @form.save
      @post = @form.post

      render location: community_post_path(@form.post.community, @form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = @community.posts.find(params[:id])
  end

  helper_method :sort
  def sort
    sorts.include?(params[:sort]) ? params[:sort] : :best
  end

  helper_method :sorts
  def sorts
    %w[best top new controversy old]
  end

  def create_params
    attributes = Api::Communities::PostsPolicy.new(pundit_user, nil).permitted_attributes_for_create
    params.require(:communities_posts_create_form).permit(attributes).merge(community: @community, user: current_user)
  end

  def update_params
    attributes = Api::Communities::PostsPolicy.new(pundit_user, @post).permitted_attributes_for_update
    params.require(:communities_posts_update_form).permit(attributes).merge(post: @post, user: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
