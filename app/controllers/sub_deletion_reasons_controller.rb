# frozen_string_literal: true

class SubDeletionReasonsController < BaseSubController
  before_action :set_deletion_reason, only: [:edit, :update, :confirm, :destroy]
  before_action -> { authorize(@sub, policy_class: SubDeletionReasonPolicy) }

  def index
    @records = DeletionReason.include(ChronologicalOrder)
                   .where(sub: @sub)
                   .includes(:sub)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? @sub.deletion_reasons.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def new
    @form = CreateSubDeletionReason.new

    render partial: "new"
  end

  def edit
    @form = UpdateSubDeletionReason.new(
      title: @deletion_reason.title,
      description: @deletion_reason.description
    )

    render partial: "edit"
  end

  def create
    @form = CreateSubDeletionReason.new(create_params)

    if @form.save
      head :no_content, location: sub_deletion_reasons_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateSubDeletionReason.new(update_params)

    if @form.save
      render partial: "sub_deletion_reasons/deletion_reason", object: @form.deletion_reason
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeleteSubDeletionReason.new(deletion_reason: @deletion_reason, current_user: current_user).call

    head :no_content
  end

  private

  def set_deletion_reason
    @deletion_reason = @sub.deletion_reasons.find(params[:id])
  end

  def create_params
    params.require(:create_sub_deletion_reason).permit(:title, :description).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_sub_deletion_reason).permit(:title, :description).merge(deletion_reason: @deletion_reason, current_user: current_user)
  end
end
