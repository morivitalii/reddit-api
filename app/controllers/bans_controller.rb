# frozen_string_literal: true

class BansController < ApplicationController
  before_action :set_community
  before_action :set_ban, only: [:edit, :update, :destroy]
  before_action -> { authorize(Ban) }, only: [:index, :new, :create]
  before_action -> { authorize(@ban) }, only: [:edit, :update, :destroy]
  decorates_assigned :bans, :ban, :community

  def index
    @bans, @pagination = query.paginate(after: params[:after])
  end

  def new
    @form = CreateBanForm.new

    render partial: "new"
  end

  def edit
    attributes = @ban.slice(:reason, :days, :permanent)

    @form = UpdateBanForm.new(attributes)

    render partial: "edit"
  end

  def create
    @form = CreateBanForm.new(create_params)

    if @form.save
      head :no_content, location: community_bans_path(@community)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateBanForm.new(update_params)

    if @form.save
      render partial: "ban"
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteBanService.new(@ban).call

    head :no_content
  end

  private

  def pundit_user
    Context.new(current_user, @community)
  end

  def query
    BansQuery.new(@community.bans).search_by_username(params[:query]).includes(:user)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_ban
    @ban = @community.bans.find(params[:id])
  end

  def create_params
    attributes = policy(Ban).permitted_attributes_for_create
    params.require(:create_ban_form).permit(attributes).merge(community: @community)
  end

  def update_params
    attributes = policy(@ban).permitted_attributes_for_update
    params.require(:update_ban_form).permit(attributes).merge(ban: @ban)
  end
end
