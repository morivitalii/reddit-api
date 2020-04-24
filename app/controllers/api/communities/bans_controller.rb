class Api::Communities::BansController < ApplicationController
  before_action :set_community
  before_action :set_ban, only: [:update, :destroy]
  before_action -> { authorize(Api::Communities::BansPolicy) }, only: [:index, :create]
  before_action -> { authorize(Api::Communities::BansPolicy, @ban) }, only: [:update, :destroy]

  def index
    query = @community.bans.includes(:user)
    bans = paginate(
      query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after].present? ? Ban.where(id: params[:after]).take : nil
    )

    render json: BanSerializer.serialize(bans)
  end

  def create
    service = Communities::CreateBan.new(create_params)

    if service.call
      render json: BanSerializer.serialize(service.ban)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def update
    service = Communities::UpdateBan.new(update_params)

    if service.call
      render json: BanSerializer.serialize(service.ban)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Communities::DeleteBan.new(ban: @ban).call

    head :no_content
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_ban
    @ban = @community.bans.find(params[:id])
  end

  def create_params
    attributes = Api::Communities::BansPolicy.new(pundit_user).permitted_attributes_for_create
    params.permit(attributes).merge(community: @community)
  end

  def update_params
    attributes = Api::Communities::BansPolicy.new(pundit_user, @ban).permitted_attributes_for_update
    params.permit(attributes).merge(ban: @ban)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
