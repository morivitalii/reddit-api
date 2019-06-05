# frozen_string_literal: true

class SubDeletionReasonsController < BaseSubController
  before_action :set_deletion_reason, only: [:edit, :update, :confirm, :destroy]

  def index
    SubDeletionReasonsPolicy.authorize!(:index, @sub)

    @records = DeletionReason.include(ChronologicalOrder)
                   .where(sub: @sub)
                   .includes(:sub)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? @sub.deletion_reasons.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.sub_deletion_reasons + 1)
                   .to_a

    if @records.size > PaginationLimits.sub_deletion_reasons
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def new
    SubDeletionReasonsPolicy.authorize!(:create, @sub)

    @form = CreateSubDeletionReason.new

    render partial: "new"
  end

  def edit
    SubDeletionReasonsPolicy.authorize!(:update, @sub)

    @form = UpdateSubDeletionReason.new(
      title: @deletion_reason.title,
      description: @deletion_reason.description
    )

    render partial: "edit"
  end

  def create
    SubDeletionReasonsPolicy.authorize!(:create, @sub)

    @form = CreateSubDeletionReason.new(create_params.merge(sub: @sub, current_user: Current.user))
    @form.save!

    head :no_content, location: sub_deletion_reasons_path(@sub)
  end

  def update
    SubDeletionReasonsPolicy.authorize!(:update, @sub)

    @form = UpdateSubDeletionReason.new(update_params.merge(deletion_reason: @deletion_reason, current_user: Current.user))
    @form.save!

    render partial: "sub_deletion_reasons/deletion_reason", object: @form.deletion_reason
  end

  def confirm
    SubDeletionReasonsPolicy.authorize!(:destroy, @sub)

    render partial: "confirm"
  end

  def destroy
    SubDeletionReasonsPolicy.authorize!(:destroy, @sub)

    DeleteSubDeletionReason.new(deletion_reason: @deletion_reason, current_user: Current.user).call

    head :no_content
  end

  private

  def set_deletion_reason
    @deletion_reason = @sub.deletion_reasons.find(params[:id])
  end

  def create_params
    params.require(:create_sub_deletion_reason).permit(:title, :description)
  end

  def update_params
    params.require(:update_sub_deletion_reason).permit(:title, :description)
  end
end
