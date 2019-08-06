# frozen_string_literal: true

class DeletionReasonsController < ApplicationController
  before_action :set_deletion_reason, only: [:edit, :update, :destroy]
  before_action :set_sub
  before_action :set_facade
  before_action -> { authorize(DeletionReason) }, only: [:index, :new, :create]
  before_action -> { authorize(@deletion_reason) }, only: [:edit, :update, :destroy]

  def index
    @records, @pagination = scope.paginate(after: params[:after])
  end

  def new
    @form = CreateDeletionReasonForm.new

    render partial: "new"
  end

  def edit
    attributes = @deletion_reason.slice(:title, :description)

    @form = UpdateDeletionReasonForm.new(attributes)

    render partial: "edit"
  end

  def create
    @form = CreateDeletionReasonForm.new(create_params)

    if @form.save
      head :no_content, location: deletion_reasons_path(sub: @sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateDeletionReasonForm.new(update_params)

    if @form.save
      render partial: "deletion_reason", object: @form.deletion_reason
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteDeletionReasonService.new(@deletion_reason).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def scope
    if @sub.present?
      DeletionReasonsQuery.new.sub(@sub)
    else
      DeletionReasonsQuery.new.global
    end
  end

  def set_facade
    @facade = DeletionReasonsFacade.new(context)
  end

  def set_sub
    if @deletion_reason.present?
      @sub = @deletion_reason.sub
    elsif params[:sub].present?
      @sub = SubsQuery.new.where_url(params[:sub]).take!
    end
  end

  def set_deletion_reason
    @deletion_reason = DeletionReason.find(params[:id])
  end

  def create_params
    attributes = policy(DeletionReason).permitted_attributes_for_create

    params.require(:create_deletion_reason_form).permit(attributes).merge(sub: @sub)
  end

  def update_params
    attributes = policy(@deletion_reason).permitted_attributes_for_update

    params.require(:update_deletion_reason_form).permit(attributes).merge(deletion_reason: @deletion_reason)
  end
end
