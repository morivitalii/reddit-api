# frozen_string_literal: true

class ThingsController < BaseThingController
  before_action :set_sort_options
  before_action :set_sort

  def show
    @topic = CommentsTree.new(
      thing: @thing,
      sort: @sort,
      after: params[:after].present? ? @sub.things.find_by_id(params[:after]) : nil
    ).build

    @post = @topic.post
    @comment = @topic.comment

    if request.xhr?
      if @comment.present?
        render partial: "nested", locals: { item: @topic.branch[:nested].first }
      else
        render partial: "nested", locals: { item: @topic.branch }
      end
    else
      render "show", status: @thing.deleted? ? :not_found : :ok
    end
  end

  private

  def set_thing
    @thing = @sub.things.find(params[:id])
  end

  def set_sort_options
    @sort_options = { best: t("best"), top: t("top"), new: t("new"), controversy: t("controversy"), old: t("old") }.with_indifferent_access
  end

  def set_sort
    @sort = params[:sort].in?(@sort_options.keys) ? params[:sort].to_sym : :best
  end
end
