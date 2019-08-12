# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_sub
  before_action :set_facade
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action -> { authorize(Page) }, only: [:index, :new, :create]
  before_action -> { authorize(@page) }, only: [:show, :edit, :update, :destroy]

  def index
    @records, @pagination = @sub.pages.paginate(order: :asc, after: params[:after])
  end

  def show
  end

  def new
    @form = CreatePageForm.new
  end

  def edit
    attributes = @page.slice(:title, :text)

    @form = UpdatePageForm.new(attributes)
  end

  def create
    @form = CreatePageForm.new(create_params)

    if @form.save
      head :no_content, location: sub_page_path(@form.page,sub, @form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdatePageForm.new(update_params)

    if @form.save
      head :no_content, location: sub_page_path(@form.page,sub, @form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeletePageService.new(@page).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def set_facade
    @facade = PagesFacade.new(context, @page)
  end

  def set_sub
    @sub = SubsQuery.new.with_url(params[:sub_id]).take!
  end

  def set_page
    @page = @sub.pages.find(params[:id])
  end

  def create_params
    attributes = policy(Page).permitted_attributes_for_create

    params.require(:create_page_form).permit(attributes).merge(sub: @sub)
  end

  def update_params
    attributes = policy(@page).permitted_attributes_for_update

    params.require(:update_page_form).permit(attributes).merge(page: @page, edited_by: current_user)
  end
end
