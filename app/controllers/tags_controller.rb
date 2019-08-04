# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]
  before_action :set_sub
  before_action :set_facade
  before_action -> { authorize(Tag) }, only: [:index, :new, :create]
  before_action -> { authorize(@tag) }, only: [:edit, :update, :destroy]

  def index
    @records, @pagination = scope.paginate(order: :asc, after: params[:after])
  end

  def new
    @form = CreateTag.new

    render partial: "new"
  end

  def edit
    attributes = @tag.slice(:title)

    @form = UpdateTag.new(attributes)

    render partial: "edit"
  end

  def create
    @form = CreateTag.new(create_params)

    if @form.save
      head :no_content, location: tags_path(sub: @sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateTag.new(update_params)

    if @form.save
      render partial: "tag", object: @form.tag
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteTag.new(tag: @tag, current_user: current_user).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def scope
    query_class = TagsQuery

    if @sub.present?
      query_class.new.sub(@sub)
    else
      query_class.new.global
    end
  end

  def set_facade
    @facade = TagsFacade.new(context)
  end

  def set_sub
    if @tag.present?
      @sub = @tag.sub
    elsif params[:sub].present?
      @sub = SubsQuery.new.where_url(params[:sub]).take!
    end
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def create_params
    attributes = policy(Tag).permitted_attributes_for_create

    params.require(:create_tag).permit(attributes).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    attributes = policy(@tag).permitted_attributes_for_update

    params.require(:update_tag).permit(attributes).merge(tag: @tag, current_user: current_user)
  end
end
