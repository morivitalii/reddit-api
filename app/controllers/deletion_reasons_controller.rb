# frozen_string_literal: true

class DeletionReasonsController < ApplicationController
  before_action :set_sub, only: [:index, :new, :create]
  before_action :set_deletion_reason, only: [:edit, :update, :confirm, :destroy]
  before_action -> { authorize(@sub, policy_class: DeletionReasonPolicy) }, only: [:index, :new, :create]
  before_action -> { authorize(@deletion_reason.sub, policy_class: DeletionReasonPolicy) }, only: [:edit, :update, :confirm, :destroy]

  def index
    @records = DeletionReason.include(ChronologicalOrder)
                   .where(sub: @sub)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? DeletionReason.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def new
    @form = CreateDeletionReason.new

    render partial: "new"
  end

  def edit
    @form = UpdateDeletionReason.new(
      title: @deletion_reason.title,
      description: @deletion_reason.description
    )

    render partial: "edit"
  end

  def create
    @form = CreateDeletionReason.new(create_params)

    if @form.save
      head :no_content, location: deletion_reasons_path(sub: @sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateDeletionReason.new(update_params)

    if @form.save
      render partial: "deletion_reason", object: @form.deletion_reason
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeleteDeletionReason.new(deletion_reason: @deletion_reason, current_user: current_user).call

    head :no_content
  end

  private

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub].downcase).take! : nil
  end

  def set_deletion_reason
    @deletion_reason = DeletionReason.find(params[:id])
  end

  def create_params
    params.require(:create_deletion_reason).permit(:title, :description).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_deletion_reason).permit(:title, :description).merge(deletion_reason: @deletion_reason, current_user: current_user)
  end
end
