# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :confirm, :destroy]
  before_action -> { authorize(Page, policy_class: PagePolicy) }

  def index
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
    @form = CreatePage.new
  end

  def edit
    @form = UpdatePage.new(
      title: @page.title,
      text: @page.text
    )
  end

  def create
    @form = CreatePage.new(create_params.merge(current_user: current_user))

    if @form.save
      head :no_content, location: page_path(@form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdatePage.new(update_params.merge(page: @page, current_user: current_user))

    if @form.save
      head :no_content, location: page_path(@form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeletePage.new(page: @page, current_user: current_user).call

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
