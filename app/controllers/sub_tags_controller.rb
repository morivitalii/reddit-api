# frozen_string_literal: true

class SubTagsController < BaseSubController
  before_action :set_tag, only: [:edit, :update, :confirm, :destroy]

  def index
    SubTagsPolicy.authorize!(:index, @sub)

    @records = Tag.include(ChronologicalOrder)
                   .where(sub: @sub)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? @sub.tags.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.sub_tags + 1)
                   .to_a

    if @records.size > PaginationLimits.sub_tags
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def new
    SubTagsPolicy.authorize!(:create, @sub)

    @form = CreateSubTag.new

    render partial: "new"
  end

  def edit
    SubTagsPolicy.authorize!(:update, @sub)

    @form = UpdateSubTag.new(title: @tag.title)

    render partial: "edit"
  end

  def create
    SubTagsPolicy.authorize!(:create, @sub)

    @form = CreateSubTag.new(create_params.merge(sub: @sub, current_user: Current.user))

    if @form.save
      head :no_content, location: sub_tags_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    SubTagsPolicy.authorize!(:update, @sub)

    @form = UpdateSubTag.new(update_params.merge(tag: @tag, current_user: Current.user))

    if @form.save
      render partial: "sub_tags/tag", object: @form.tag
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    SubTagsPolicy.authorize!(:destroy, @sub)

    render partial: "confirm"
  end

  def destroy
    SubTagsPolicy.authorize!(:destroy, @sub)

    DeleteSubTag.new(tag: @tag, current_user: Current.user).call

    head :no_content
  end

  private

  def set_tag
    @tag = @sub.tags.find(params[:id])
  end

  def create_params
    params.require(:create_sub_tag).permit(:title)
  end

  def update_params
    params.require(:update_sub_tag).permit(:title)
  end
end
