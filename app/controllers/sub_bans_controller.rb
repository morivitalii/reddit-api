# frozen_string_literal: true

class SubBansController < BaseSubController
  before_action :set_ban, only: [:edit, :update, :confirm, :destroy]

  def index
    SubBansPolicy.authorize!(:index, @sub)

    @records = Ban.include(ReverseChronologicalOrder)
                   .where(sub: @sub)
                   .includes(:user, :banned_by)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? @sub.bans.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def search
    SubBansPolicy.authorize!(:index, @sub)

    @records = @sub.bans.search(params[:query]).all

    render "index"
  end

  def new
    SubBansPolicy.authorize!(:create, @sub)

    @form = CreateSubBan.new

    render partial: "new"
  end

  def edit
    SubBansPolicy.authorize!(:update, @sub)

    @form = UpdateSubBan.new(
      reason: @ban.reason,
      days: @ban.days,
      permanent: @ban.permanent
    )

    render partial: "edit"
  end

  def create
    SubBansPolicy.authorize!(:create, @sub)

    @form = CreateSubBan.new(create_params.merge(sub: @sub, current_user: Current.user))

    if @form.save
      head :no_content, location: sub_bans_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    SubBansPolicy.authorize!(:update, @sub)

    @form = UpdateSubBan.new(update_params.merge(ban: @ban, current_user: Current.user))

    if @form.save
      render partial: "ban", object: @form.ban
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    SubBansPolicy.authorize!(:destroy, @sub)

    render partial: "confirm"
  end

  def destroy
    SubBansPolicy.authorize!(:destroy, @sub)
    
    DeleteSubBan.new(ban: @ban, current_user: Current.user).call

    head :no_content
  end

  private

  def set_ban
    @ban = @sub.bans.find(params[:id])
  end

  def create_params
    params.require(:create_sub_ban).permit(:username, :reason, :days, :permanent)
  end

  def update_params
    params.require(:update_sub_ban).permit(:reason, :days, :permanent)
  end
end
