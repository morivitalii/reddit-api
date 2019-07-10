# frozen_string_literal: true

class ThingsController < ApplicationController
  before_action -> { authorize(Thing) }
  before_action :set_thing, only: [:show]
  before_action :set_sort_options, only: [:show]
  before_action :set_sort, only: [:show]

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

  def actions
    ids = params[:ids].present? ? params[:ids].split(",").map(&:to_i).compact.uniq : []

    return head :no_content if ids.blank? && ids.size > 500

    things = Thing.includes(:sub, :approved_by).where(id: ids).to_a
    votes = Vote.where(thing: things, user: current_user).to_a
    bookmarks = Bookmark.where(thing: things, user: current_user).to_a

    things.each do |thing|
      thing.vote = votes.find { |vote| thing.id == vote.thing_id }
      thing.bookmark = bookmarks.find { |bookmark| thing.id == bookmark.thing_id }
    end

    html = render_to_string(partial: "things/actions", collection: things, as: :thing)

    render plain: html
  end

  private

  def set_thing
    @thing = Thing.find(params[:id])
  end

  def set_sort_options
    @sort_options = { best: t("best"), top: t("top"), new: t("new"), controversy: t("controversy"), old: t("old") }.with_indifferent_access
  end

  def set_sort
    @sort = params[:sort].in?(@sort_options.keys) ? params[:sort].to_sym : :best
  end
end
