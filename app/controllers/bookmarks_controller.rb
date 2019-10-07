# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action -> { authorize(Bookmark) }
  before_action :set_bookmarkable
  decorates_assigned :bookmarkable

  def create
    @bookmarkable.bookmark = CreateBookmarkService.new(@bookmarkable, current_user).call
    @bookmarkable = @bookmarkable.decorate

    render json: {bookmark_link: @bookmarkable.bookmark_link}
  end

  def destroy
    DeleteBookmarkService.new(@bookmarkable, current_user).call
    @bookmarkable.bookmark = nil
    @bookmarkable = @bookmarkable.decorate

    render json: {bookmark_link: @bookmarkable.bookmark_link}
  end

  private

  def set_bookmarkable
    if params[:post_id].present?
      @bookmarkable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @bookmarkable = Comment.find(params[:comment_id])
    end
  end
end
