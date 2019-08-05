# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action -> { authorize(Bookmark) }
  before_action :set_user, only: [:index, :comments]
  before_action :set_bookmarkable, only: [:create, :destroy]
  before_action :set_facade

  def index
    @records, @pagination = posts_scope.paginate(after: params[:after])
    @records = @records.map(&:bookmarkable).map(&:decorate)
  end

  def comments
    @records, @pagination = comments_scope.paginate(after: params[:after])
    @records = @records.map(&:bookmarkable).map(&:decorate)
  end

  def create
    CreateBookmarkService.new(@bookmarkable, current_user).call
    @bookmarkable.decorate!

    render json: {
      bookmarked: true,
      bookmark_link_tooltip_message: @bookmarkable.bookmark_link_tooltip_message
    }
  end

  def destroy
    DeleteBookmark.new(@bookmarkable, current_user).call
    @bookmarkable.decorate!

    render json: {
      bookmarked: false,
      bookmark_link_tooltip_message: @bookmarkable.bookmark_link_tooltip_message
    }
  end

  private

  def posts_scope
    BookmarksQuery.new(scope).filter_by_bookmarkable_type("Post").includes(bookmarkable: [:user, :sub])
  end

  def comments_scope
    BookmarksQuery.new(scope).filter_by_bookmarkable_type("Comment").includes(bookmarkable: [:user, post: :sub])
  end

  def scope
    BookmarksQuery.new.where_user(@user)
  end

  def set_facade
    @facade = BookmarksFacade.new(context, @user)
  end

  def set_user
    @user = current_user
  end

  def set_bookmarkable
    if params[:post_id].present?
      @bookmarkable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @bookmarkable = Comment.find(params[:comment_id])
    end
  end
end
