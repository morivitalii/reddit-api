class Api::Communities::MutesController < ApplicationController
  before_action :set_community
  before_action :set_mute, only: [:show, :update, :destroy]
  before_action -> { authorize(Api::Communities::MutesPolicy) }, only: [:index, :create]
  before_action -> { authorize(Api::Communities::MutesPolicy, @mute) }, only: [:show, :update, :destroy]

  def index
    query = @community.mutes.includes(:source, :target, :created_by, :updated_by)
    mutes = paginate(
      query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after].present? ? Mute.where(id: params[:after]).take : nil
    )

    render json: MuteSerializer.serialize(mutes)
  end

  def show
    render json: MuteSerializer.serialize(@mute)
  end

  def create
    service = Communities::CreateMute.new(create_params)

    if service.call
      render json: MuteSerializer.serialize(service.mute)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def update
    service = Communities::UpdateMute.new(update_params)

    if service.call
      render json: MuteSerializer.serialize(service.mute)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Communities::DeleteMute.new(mute: @mute).call

    head :no_content
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_mute
    @mute = @community.mutes.includes(:source, :target, :created_by, :updated_by).find(params[:id])
  end

  def create_params
    attributes = Api::Communities::MutesPolicy.new(pundit_user).permitted_attributes_for_create
    params.permit(attributes).merge(community: @community, created_by: current_user)
  end

  def update_params
    attributes = Api::Communities::MutesPolicy.new(pundit_user, @mute).permitted_attributes_for_update
    params.permit(attributes).merge(mute: @mute, updated_by: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
