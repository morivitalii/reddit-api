# frozen_string_literal: true

class BookmarksController < ApplicationController
  layout "narrow"

  before_action -> { authorize(Bookmark) }
  before_action :set_user, only: [:index]
  before_action :set_navigation_title, only: [:index]
  before_action :set_thing, only: [:create, :destroy]

  def index
    @records = Bookmark.type(type)
                   .where(user: @user)
                   .includes(bookmarkable: [:sub, :user, :post])
                   .reverse_chronologically(after)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:bookmarkable)
  end

  def create
    CreateBookmark.new(@thing, current_user).call

    head :no_content
  end

  def destroy
    DeleteBookmark.new(@thing, current_user).call

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

  def type
    ThingsTypes.new(params[:type]).key&.to_s&.classify
  end

  def after
    params[:after].present? ? Bookmark.find_by_id(params[:after]) : nil
  end
end
