# frozen_string_literal: true

class BansController < ApplicationController
  before_action :set_ban, only: [:edit, :update, :destroy]
  before_action :set_sub
  before_action -> { authorize(Ban) }, only: [:index, :search, :new, :create]
  before_action -> { authorize(@ban) }, only: [:edit, :update, :destroy]

  def index
    @records, @pagination_record = Ban.includes(:user, :banned_by).where(sub: @sub).paginate(after: params[:after])
  end

  def search
    @records = Ban.where(sub: @sub).search(params[:query]).all

    render "index"
  end

  def new
    @form = CreateBan.new

    render partial: "new"
  end

  def edit
    attributes = @ban.slice(:reason, :days, :permanent)

    @form = UpdateBan.new(attributes)

    render partial: "edit"
  end

  def create
    @form = CreateBan.new(create_params)

    if @form.save
      head :no_content, location: bans_path(sub: @sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateBan.new(update_params)

    if @form.save
      render partial: "ban", object: @form.ban
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteBan.new(ban: @ban, current_user: current_user).call

    head :no_content
  end

  private

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = @ban.present? ? @ban.sub : Sub.find_by_lower_url(params[:sub])
  end

  def set_ban
    @ban = Ban.find(params[:id])
  end

  def create_params
    attributes = policy(Ban).permitted_attributes_for_create

    params.require(:create_ban).permit(attributes).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    attributes = policy(@ban).permitted_attributes_for_update

    params.require(:update_ban).permit(attributes).merge(ban: @ban, current_user: current_user)
  end
end
