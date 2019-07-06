# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :confirm, :destroy]

  def index
    PagesPolicy.authorize!(:index)
    @records = Page.include(ChronologicalOrder)
                   .global
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? Page.global.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def show
  end

  def new
    PagesPolicy.authorize!(:create)

    @form = CreatePage.new
  end

  def edit
    PagesPolicy.authorize!(:update)

    @form = UpdatePage.new(
      title: @page.title,
      text: @page.text
    )
  end

  def create
    PagesPolicy.authorize!(:create)

    @form = CreatePage.new(create_params.merge(current_user: Current.user))

    if @form.save
      head :no_content, location: page_path(@form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    PagesPolicy.authorize!(:update)

    @form = UpdatePage.new(update_params.merge(page: @page, current_user: Current.user))

    if @form.save
      head :no_content, location: page_path(@form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    PagesPolicy.authorize!(:destroy)

    render partial: "confirm"
  end

  def destroy
    PagesPolicy.authorize!(:destroy)

    DeletePage.new(page: @page, current_user: Current.user).call

    head :no_content
  end

  private

  def set_page
    @page = Page.global.find(params[:id])
  end

  def create_params
    params.require(:create_page).permit(:title, :text)
  end

  def update_params
    params.require(:update_page).permit(:title, :text)
  end
end
