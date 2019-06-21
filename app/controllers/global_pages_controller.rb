# frozen_string_literal: true

class GlobalPagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :confirm, :destroy]

  def index
    GlobalPagesPolicy.authorize!(:index)
    @records = Page.include(ChronologicalOrder)
                   .global
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? Page.global.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.global_pages + 1)
                   .to_a

    if @records.size > PaginationLimits.global_pages
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def show
  end

  def new
    GlobalPagesPolicy.authorize!(:create)

    @form = CreateGlobalPage.new
  end

  def edit
    GlobalPagesPolicy.authorize!(:update)

    @form = UpdateGlobalPage.new(
      title: @page.title,
      text: @page.text
    )
  end

  def create
    GlobalPagesPolicy.authorize!(:create)

    @form = CreateGlobalPage.new(create_params.merge(current_user: Current.user))

    if @form.save
      head :no_content, location: global_page_path(@form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    GlobalPagesPolicy.authorize!(:update)

    @form = UpdateGlobalPage.new(update_params.merge(page: @page, current_user: Current.user))

    if @form.save
      head :no_content, location: global_page_path(@form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    GlobalPagesPolicy.authorize!(:destroy)

    render partial: "confirm"
  end

  def destroy
    GlobalPagesPolicy.authorize!(:destroy)

    DeleteGlobalPage.new(page: @page, current_user: Current.user).call

    head :no_content
  end

  private

  def set_page
    @page = Page.global.find(params[:id])
  end

  def create_params
    params.require(:create_global_page).permit(:title, :text)
  end

  def update_params
    params.require(:update_global_page).permit(:title, :text)
  end
end
