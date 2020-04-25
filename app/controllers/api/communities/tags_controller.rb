class Api::Communities::TagsController < ApplicationController
  before_action :set_community
  before_action :set_tag, only: [:show, :update, :destroy]
  before_action -> { authorize(Api::Communities::TagsPolicy) }, only: [:index, :create]
  before_action -> { authorize(Api::Communities::TagsPolicy, @tag) }, only: [:show, :update, :destroy]

  def index
    query = @community.tags.includes(:community)
    tags = paginate(
      query,
      attributes: [:id],
      order: :asc,
      limit: 25,
      after: params[:after].present? ? Tag.where(id: params[:after]).take : nil
    )

    render json: TagSerializer.serialize(tags)
  end

  def show
    render json: TagSerializer.serialize(@tag)
  end

  def create
    service = Communities::CreateTag.new(create_params)

    if service.call
      render json: TagSerializer.serialize(service.tag)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def update
    service = Communities::UpdateTag.new(update_params)

    if service.call
      render json: TagSerializer.serialize(service.tag)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Communities::DeleteTag.new(tag: @tag).call

    head :no_content
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_tag
    @tag = @community.tags.find(params[:id])
  end

  def create_params
    attributes = Api::Communities::TagsPolicy.new(pundit_user).permitted_attributes
    params.permit(attributes).merge(community: @community)
  end

  def update_params
    attributes = Api::Communities::TagsPolicy.new(pundit_user, @tag).permitted_attributes
    params.permit(attributes).merge(tag: @tag)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
