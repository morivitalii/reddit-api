# frozen_string_literal: true

class SubModeratorsController < BaseSubController
  before_action :set_moderator, only: [:edit, :update, :confirm, :destroy]

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
    SubModeratorsPolicy.authorize!(:create, @sub)

    @form = CreateSubModerator.new

    render partial: "new"
  end

  def edit
    SubModeratorsPolicy.authorize!(:update, @sub)

    @form = UpdateSubModerator.new(master: @moderator.master)

    render partial: "edit"
  end

  def create
    SubModeratorsPolicy.authorize!(:create, @sub)

    @form = CreateSubModerator.new(create_params.merge(sub: @sub, current_user: Current.user))

    if @form.save
      head :no_content, location: sub_moderators_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    SubModeratorsPolicy.authorize!(:update, @sub)

    @form = UpdateSubModerator.new(update_params.merge(moderator: @moderator, current_user: Current.user))

    if @form.save
      render partial: "moderator", object: @form.moderator
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    SubModeratorsPolicy.authorize!(:destroy, @sub)

    render partial: "confirm"
  end

  def destroy
    SubModeratorsPolicy.authorize!(:destroy, @sub)

    DeleteSubModerator.new(moderator: @moderator, current_user: Current.user).call

    head :no_content
  end

  private

  def set_moderator
    @moderator = @sub.moderators.find(params[:id])
  end

  def create_params
    params.require(:create_sub_moderator).permit(:username, :master)
  end

  def update_params
    params.require(:update_sub_moderator).permit(:master)
  end
end
