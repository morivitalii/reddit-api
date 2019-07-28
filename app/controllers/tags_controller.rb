# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_sub, only: [:index, :new, :create]
  before_action :set_tag, only: [:edit, :update, :destroy]
  before_action -> { authorize(Tag) }

  def index
    @records, @pagination_record = Tag.where(sub: @sub).paginate(order: :asc, after: params[:after])
  end

  def new
    @form = CreateTag.new

    render partial: "new"
  end

  def edit
    @form = UpdateTag.new(title: @tag.title)

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

  def pundit_user
    UserContext.new(current_user, @sub || @tag&.sub)
  end

  def set_sub
    @sub = Sub.find_by_lower_url(params[:sub])
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def create_params
    params.require(:create_tag).permit(:title).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_tag).permit(:title).merge(tag: @tag, current_user: current_user)
  end
end
