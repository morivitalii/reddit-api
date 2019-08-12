# frozen_string_literal: true

class BansController < ApplicationController
  before_action :set_sub
  before_action :set_facade
  before_action :set_ban, only: [:edit, :update, :destroy]
  before_action -> { authorize(Ban) }, only: [:index, :new, :create]
  before_action -> { authorize(@ban) }, only: [:edit, :update, :destroy]

  def index
    @records, @pagination = query.paginate(after: params[:after])
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
      head :no_content, location: sub_bans_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateBanForm.new(update_params)

    if @form.save
      render partial: "ban", object: @form.ban
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteBanService.new(@ban).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def set_sub
    @sub = SubsQuery.new.with_url(params[:sub_id]).take!
  end

  def set_facade
    @facade = BansFacade.new(context)
  end

  def set_ban
    @ban = @sub.bans.find(params[:id])
  end

  def query
    BansQuery.new(@sub.bans).search_by_username(params[:query]).includes(:user, :banned_by)
  end

  def create_params
    attributes = policy(Ban).permitted_attributes_for_create

    params.require(:create_ban_form).permit(attributes).merge(sub: @sub, banned_by: current_user)
  end

  def update_params
    attributes = policy(@ban).permitted_attributes_for_update

    params.require(:update_ban_form).permit(attributes).merge(ban: @ban)
  end
end
