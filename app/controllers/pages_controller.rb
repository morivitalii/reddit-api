# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_sub, only: [:index, :new, :create]
  before_action :set_page, only: [:show, :edit, :update, :confirm, :destroy]
  before_action -> { authorize(@sub, policy_class: PagePolicy) }, only: [:index, :new, :create]
  before_action -> { authorize(@page.sub, policy_class: PagePolicy) }, only: [:show, :edit, :update, :confirm, :destroy]

  def index
    @records = Page.include(Chronological)
                   .where(sub: @sub)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? Page.find_by_id(params[:after]) : nil)
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
    @form = CreatePage.new(create_params)

    if @form.save
      head :no_content, location: page_path(@form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdatePage.new(update_params)

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

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub]).take! : nil
  end

  def set_page
    @page = Page.find(params[:id])
  end

  def create_params
    params.require(:create_page).permit(:title, :text).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_page).permit(:title, :text).merge(page: @page, current_user: current_user)
  end
end
