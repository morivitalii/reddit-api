# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_sub, only: [:index, :new, :create]
  before_action :set_tag, only: [:edit, :update, :confirm, :destroy]
  before_action -> { authorize(@sub, policy_class: TagPolicy) }, only: [:index, :new, :create]
  before_action -> { authorize(@tag.sub, policy_class: TagPolicy) }, only: [:edit, :update, :confirm, :destroy]

  def index
    @records = Tag.where(sub: @sub).chronologically(after).limit(51).to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
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

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeleteTag.new(tag: @tag, current_user: current_user).call

    head :no_content
  end

  private

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub].downcase).take! : nil
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

  def after
    params[:after].present? ? Tag.find_by_id(params[:after]) : nil
  end
end
