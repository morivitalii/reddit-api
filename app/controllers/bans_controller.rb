# frozen_string_literal: true

class BansController < ApplicationController
  before_action :set_ban, only: [:edit, :update, :confirm, :destroy]

  def index
    BansPolicy.authorize!(:index)

    @records = Ban.include(ReverseChronologicalOrder)
                   .global
                   .includes(:user, :banned_by)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? Ban.global.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def search
    BansPolicy.authorize!(:index)

    @records = Ban.global.search(params[:query]).all

    render "index"
  end

  def new
    BansPolicy.authorize!(:create)

    @form = CreateBan.new

    render partial: "new"
  end

  def edit
    BansPolicy.authorize!(:update)

    @form = UpdateBan.new(
      reason: @ban.reason,
      days: @ban.days,
      permanent: @ban.permanent
    )

    render partial: "edit"
  end

  def create
    BansPolicy.authorize!(:create)

    @form = CreateBan.new(create_params.merge(current_user: current_user))

    if @form.save
      head :no_content, location: bans_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    BansPolicy.authorize!(:update)

    @form = UpdateBan.new(update_params.merge(ban: @ban, current_user: current_user))

    if @form.save
      render partial: "ban", object: @form.ban
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    BansPolicy.authorize!(:destroy)

    render partial: "confirm"
  end

  def destroy
    BansPolicy.authorize!(:destroy)

    DeleteBan.new(ban: @ban, current_user: current_user).call

    head :no_content
  end

  private

  def set_ban
    @ban = Ban.global.find(params[:id])
  end

  def create_params
    params.require(:create_ban).permit(:username, :reason, :days, :permanent)
  end

  def update_params
    params.require(:update_ban).permit(:reason, :days, :permanent)
  end
end
