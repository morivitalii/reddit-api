# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_sub
  before_action :set_facade
  before_action :set_tag, only: [:edit, :update, :destroy]
  before_action -> { authorize(Tag) }, only: [:index, :new, :create]
  before_action -> { authorize(@tag) }, only: [:edit, :update, :destroy]

  def index
    @records, @pagination = @sub.tags.paginate(order: :asc, after: params[:after])
  end

  def new
    @form = CreateTagForm.new

    render partial: "new"
  end

  def edit
    attributes = @tag.slice(:title)

    @form = UpdateTagForm.new(attributes)

    render partial: "edit"
  end

  def create
    @form = CreateTagForm.new(create_params)

    if @form.save
      head :no_content, location: sub_tags_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateTagForm.new(update_params)

    if @form.save
      render partial: "tag", object: @form.tag
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteTagService.new(@tag).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def set_sub
    @sub = SubsQuery.new.with_url(params[:sub_id]).take!
  end

  def set_facade
    @facade = TagsFacade.new(context)
  end

  def set_tag
    @tag = @sub.tags.find(params[:id])
  end

  def create_params
    attributes = policy(Tag).permitted_attributes_for_create

    params.require(:create_tag_form).permit(attributes).merge(sub: @sub)
  end

  def update_params
    attributes = policy(@tag).permitted_attributes_for_update

    params.require(:update_tag_form).permit(attributes).merge(tag: @tag)
  end
end
