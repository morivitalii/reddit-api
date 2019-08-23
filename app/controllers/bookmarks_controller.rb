# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :set_user
  before_action -> { authorize(@user, policy_class: BookmarkPolicy) }, only: [:posts_index, :comments_index]
  before_action -> { authorize(Bookmark) }, only: [:create, :destroy]
  before_action :set_bookmarkable, only: [:create, :destroy]
  decorates_assigned :user, :posts, :comments, :bookmarkable

  def posts_index
    @bookmarks, @pagination = posts_query.paginate(after: params[:after])
    @posts = @bookmarks.map(&:bookmarkable)
  end

  def comments_index
    @bookmarks, @pagination = comments_query.paginate(after: params[:after])
    @comments = @bookmarks.map(&:bookmarkable)
  end

  def create
    @bookmarkable.bookmark = CreateBookmarkService.new(@bookmarkable, current_user).call
    @bookmarkable = @bookmarkable.decorate

    render json: { bookmark_link: @bookmarkable.bookmark_link }
  end

  def destroy
    DeleteBookmarkService.new(@bookmarkable, current_user).call
    @bookmarkable.bookmark = nil
    @bookmarkable = @bookmarkable.decorate

    render json: { bookmark_link: @bookmarkable.bookmark_link }
  end

  private

  def posts_query
    BookmarksQuery.new(@user.bookmarks).posts_bookmarks.includes(bookmarkable: [:user, :community])
  end

  def comments_query
    BookmarksQuery.new(@user.bookmarks).comments_bookmarks.includes(bookmarkable: [:user, :post, :community])
  end

  def set_user
    @user = params[:user_id].present? ? UsersQuery.new.with_username(params[:user_id]).take! : current_user
  end

  def set_bookmarkable
    if params[:post_id].present?
      @bookmarkable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @bookmarkable = Comment.find(params[:comment_id])
    end
  end
end
