# frozen_string_literal: true

class SubModeratorsController < BaseSubController
  before_action :set_moderator, only: [:edit, :update, :confirm, :destroy]
  before_action -> { authorize(@sub, policy_class: SubModeratorPolicy) }

  def index
    @records = Moderator.include(ChronologicalOrder)
                   .where(sub: @sub)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? @sub.moderators.find_by_id(params[:after]) : nil)
                   .includes(:user, :invited_by)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def search
    @records = @sub.moderators.search(params[:query]).all

    render "index"
  end

  def new
    @form = CreateSubModerator.new

    render partial: "new"
  end

  def edit
    @form = UpdateSubModerator.new(master: @moderator.master)

    render partial: "edit"
  end

  def create
    @form = CreateSubModerator.new(create_params)

    if @form.save
      head :no_content, location: sub_moderators_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateSubModerator.new(update_params)

    if @form.save
      render partial: "moderator", object: @form.moderator
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeleteSubModerator.new(moderator: @moderator, current_user: current_user).call

    head :no_content
  end

  private

  def set_moderator
    @moderator = @sub.moderators.find(params[:id])
  end

  def create_params
    params.require(:create_sub_moderator).permit(:username, :master).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_sub_moderator).permit(:master).merge(moderator: @moderator, current_user: current_user)
  end
end
