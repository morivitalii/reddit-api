# frozen_string_literal: true

class GlobalDeletionReasonsController < ApplicationController
  before_action :set_deletion_reason, only: [:edit, :update, :confirm, :destroy]

  def index
    GlobalDeletionReasonsPolicy.authorize!(:index)

    @records = DeletionReason.include(ChronologicalOrder)
                   .global
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? DeletionReason.global.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.global_deletion_reasons + 1)
                   .to_a

    if @records.size > PaginationLimits.global_deletion_reasons
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def new
    GlobalDeletionReasonsPolicy.authorize!(:create)

    @form = CreateGlobalDeletionReason.new

    render partial: "new"
  end

  def edit
    GlobalDeletionReasonsPolicy.authorize!(:update)

    @form = UpdateGlobalDeletionReason.new(
        title: @deletion_reason.title,
        description: @deletion_reason.description
    )

    render partial: "edit"
  end

  def create
    GlobalDeletionReasonsPolicy.authorize!(:create)

    @form = CreateGlobalDeletionReason.new(create_params.merge(current_user: Current.user))

    if @form.save
      head :no_content, location: global_deletion_reasons_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    GlobalDeletionReasonsPolicy.authorize!(:update)

    @form = UpdateGlobalDeletionReason.new(update_params.merge(deletion_reason: @deletion_reason, current_user: Current.user))

    if @form.save
      render partial: "global_deletion_reasons/deletion_reason", object: @form.deletion_reason
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    GlobalDeletionReasonsPolicy.authorize!(:destroy)

    render partial: "confirm"
  end

  def destroy
    GlobalDeletionReasonsPolicy.authorize!(:destroy)

    DeleteGlobalDeletionReason.new(deletion_reason: @deletion_reason, current_user: Current.user).call

    head :no_content
  end

  private

  def set_deletion_reason
    @deletion_reason = DeletionReason.global.find(params[:id])
  end

  def create_params
    params.require(:create_global_deletion_reason).permit(:title, :description)
  end

  def update_params
    params.require(:update_global_deletion_reason).permit(:title, :description)
  end
end
