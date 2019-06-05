# frozen_string_literal: true

class GlobalBansController < ApplicationController
  before_action :set_ban, only: [:edit, :update, :confirm, :destroy]

  def index
    GlobalBansPolicy.authorize!(:index)

    @records = Ban.include(ReverseChronologicalOrder)
                   .global
                   .includes(:user, :banned_by)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? Ban.global.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.global_bans + 1)
                   .to_a

    if @records.size > PaginationLimits.global_bans
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def search
    GlobalBansPolicy.authorize!(:index)

    @records = Ban.global.search(params[:query]).all

    render "index"
  end

  def new
    GlobalBansPolicy.authorize!(:create)

    @form = CreateGlobalBan.new

    render partial: "new"
  end

  def edit
    GlobalBansPolicy.authorize!(:update)

    @form = UpdateGlobalBan.new(
      reason: @ban.reason,
      days: @ban.days,
      permanent: @ban.permanent
    )

    render partial: "edit"
  end

  def create
    GlobalBansPolicy.authorize!(:create)

    @form = CreateGlobalBan.new(create_params.merge(current_user: Current.user))
    @form.save!

    head :no_content, location: global_bans_path
  end

  def update
    GlobalBansPolicy.authorize!(:update)

    @form = UpdateGlobalBan.new(update_params.merge(ban: @ban, current_user: Current.user))
    @form.save!

    render partial: "ban", object: @form.ban
  end

  def confirm
    GlobalBansPolicy.authorize!(:destroy)

    render partial: "confirm"
  end

  def destroy
    GlobalBansPolicy.authorize!(:destroy)

    DeleteGlobalBan.new(ban: @ban, current_user: Current.user).call

    head :no_content
  end

  private

  def set_ban
    @ban = Ban.global.find(params[:id])
  end

  def create_params
    params.require(:create_global_ban).permit(:username, :reason, :days, :permanent)
  end

  def update_params
    params.require(:update_global_ban).permit(:reason, :days, :permanent)
  end
end
