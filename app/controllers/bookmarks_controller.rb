# frozen_string_literal: true

class BookmarksController < ApplicationController
  layout "narrow"

  before_action -> { authorize(Bookmark) }
  before_action :set_user, only: [:index]
  before_action :set_navigation_title, only: [:index]
  before_action :set_thing, only: [:create, :destroy]

  def index
    @records = Bookmark.include(ReverseChronological)
                   .joins(:thing)
                   .merge(Thing.not_deleted)
                   .thing_type(ThingsTypes.new(params[:thing_type]).key)
                   .where(user: @user)
                   .reverse_chronologically(params[:after].present? ? @user.bookmarks.find_by_id(params[:after]) : nil)
                   .includes(thing: [:sub, :user, :post])
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:thing)
  end

  def create
    CreateBookmark.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  def destroy
    DeleteBookmark.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  private

  def set_user
    @user = current_user
  end

  def set_navigation_title
    @navigation_title = @user.username
  end

  def set_thing
    @thing = Thing.find(params[:thing_id])
  end
end
