# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :set_sub
  before_action -> { authorize(Page) }, only: [:index, :new, :create]
  before_action -> { authorize(@page) }, only: [:show, :edit, :update, :destroy]

  def index
    @records, @pagination_record = scope.paginate(order: :asc, after: params[:after])
  end

  def show
  end

  def new
    @form = CreatePage.new
  end

  def edit
    attributes = @page.slice(:title, :text)

    @form = UpdatePage.new(attributes)
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

  def destroy
    DeletePage.new(page: @page, current_user: current_user).call

    head :no_content
  end

  private

  def scope
    query_class = PagesQuery

    if @sub.present?
      query_class.new.where_sub(@sub)
    else
      query_class.new.where_global
    end
  end

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    if @page.present?
      @sub = @page.sub
    elsif params[:sub].present?
      @sub = SubsQuery.new.where_url(params[:sub]).take!
    end
  end

  def set_page
    @page = Page.find(params[:id])
  end

  def create_params
    attributes = policy(Page).permitted_attributes_for_create

    params.require(:create_page).permit(attributes).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    attributes = policy(@page).permitted_attributes_for_update

    params.require(:update_page).permit(attributes).merge(page: @page, current_user: current_user)
  end
end
