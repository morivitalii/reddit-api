# frozen_string_literal: true

class DeletionReasonsController < ApplicationController
  before_action :set_deletion_reason, only: [:edit, :update, :confirm, :destroy]

  def index
    DeletionReasonsPolicy.authorize!(:index)

    @records = DeletionReason.include(ChronologicalOrder)
                   .global
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? DeletionReason.global.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.deletion_reasons + 1)
                   .to_a

    if @records.size > PaginationLimits.deletion_reasons
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def new
    DeletionReasonsPolicy.authorize!(:create)

    @form = CreateDeletionReason.new

    render partial: "new"
  end

  def edit
    DeletionReasonsPolicy.authorize!(:update)

    @form = UpdateDeletionReason.new(
        title: @deletion_reason.title,
        description: @deletion_reason.description
    )

    render partial: "edit"
  end

  def create
    DeletionReasonsPolicy.authorize!(:create)

    @form = CreateDeletionReason.new(create_params.merge(current_user: Current.user))

    if @form.save
      head :no_content, location: deletion_reasons_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    DeletionReasonsPolicy.authorize!(:update)

    @form = UpdateDeletionReason.new(update_params.merge(deletion_reason: @deletion_reason, current_user: Current.user))

    if @form.save
      render partial: "deletion_reason", object: @form.deletion_reason
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    DeletionReasonsPolicy.authorize!(:destroy)

    render partial: "confirm"
  end

  def destroy
    DeletionReasonsPolicy.authorize!(:destroy)

    DeleteDeletionReason.new(deletion_reason: @deletion_reason, current_user: Current.user).call

    head :no_content
  end

  private

  def set_deletion_reason
    @deletion_reason = DeletionReason.global.find(params[:id])
  end

  def create_params
    params.require(:create_deletion_reason).permit(:title, :description)
  end

  def update_params
    params.require(:update_deletion_reason).permit(:title, :description)
  end
end
