# frozen_string_literal: true

class SubTagsController < BaseSubController
  before_action :set_tag, only: [:edit, :update, :confirm, :destroy]
  before_action -> { authorize(@sub, policy_class: SubTagPolicy) }

  def index
    @records = Tag.where(sub: @sub)
                   .chronologically(params[:after].present? ? @sub.tags.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def new
    @form = CreateSubTag.new

    render partial: "new"
  end

  def edit
    @form = UpdateSubTag.new(title: @tag.title)

    render partial: "edit"
  end

  def create
    @form = CreateSubTag.new(create_params)

    if @form.save
      head :no_content, location: sub_tags_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateSubTag.new(update_params)

    if @form.save
      render partial: "sub_tags/tag", object: @form.tag
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeleteSubTag.new(tag: @tag, current_user: current_user).call

    head :no_content
  end

  private

  def set_tag
    @tag = @sub.tags.find(params[:id])
  end

  def create_params
    params.require(:create_sub_tag).permit(:title).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_sub_tag).permit(:title).merge(tag: @tag, current_user: current_user)
  end
end
