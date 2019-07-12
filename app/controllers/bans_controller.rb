# frozen_string_literal: true

class BansController < ApplicationController
  before_action :set_sub, only: [:index, :search, :new, :create]
  before_action :set_ban, only: [:edit, :update, :confirm, :destroy]
  before_action -> { authorize(@sub, policy_class: BanPolicy) }, only: [:index, :search, :new, :create]
  before_action -> { authorize(@ban.sub, policy_class: BanPolicy) }, only: [:edit, :update, :confirm, :destroy]

  def index
    @records = Ban.include(ReverseChronological)
                   .where(sub: @sub)
                   .includes(:user, :banned_by)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? Ban.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
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
    @form = UpdateBan.new(
      reason: @ban.reason,
      days: @ban.days,
      permanent: @ban.permanent
    )

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

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeleteBan.new(ban: @ban, current_user: current_user).call

    head :no_content
  end

  private

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub].downcase).take! : nil
  end

  def set_ban
    @ban = Ban.find(params[:id])
  end

  def create_params
    params.require(:create_ban).permit(:username, :reason, :days, :permanent).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_ban).permit(:reason, :days, :permanent).merge(ban: @ban, current_user: current_user)
  end
end
