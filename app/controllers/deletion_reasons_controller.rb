# frozen_string_literal: true

class DeletionReasonsController < ApplicationController
  before_action :set_deletion_reason, only: [:edit, :update, :destroy]
  before_action :set_sub
  before_action -> { authorize(DeletionReason) }, only: [:index, :new, :create]
  before_action -> { authorize(@deletion_reason) }, only: [:edit, :update, :destroy]

  def index
    @records, @pagination_record = scope.paginate(after: params[:after])
  end

  def new
    @form = CreateDeletionReason.new

    render partial: "new"
  end

  def edit
    attributes = @deletion_reason.slice(:title, :description)

    @form = UpdateDeletionReason.new(attributes)

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

  def destroy
    DeleteDeletionReason.new(deletion_reason: @deletion_reason, current_user: current_user).call

    head :no_content
  end

  private

  def scope
    if @sub.present?
      DeletionReasonsQuery.new.where_sub(@sub)
    else
      DeletionReasonsQuery.new.where_global
    end
  end

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = @deletion_reason.present? ? @deletion_reason.sub : SubsQuery.new.where_url(params[:sub]).take!
  end

  def set_deletion_reason
    @deletion_reason = DeletionReason.find(params[:id])
  end

  def create_params
    attributes = policy(DeletionReason).permitted_attributes_for_create

    params.require(:create_deletion_reason).permit(attributes).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    attributes = policy(@deletion_reason).permitted_attributes_for_update

    params.require(:update_deletion_reason).permit(attributes).merge(deletion_reason: @deletion_reason, current_user: current_user)
  end
end
