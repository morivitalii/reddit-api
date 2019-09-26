# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :set_user
  before_action -> { authorize(@user, policy_class: BookmarkPolicy) }, only: [:index]
  before_action -> { authorize(Bookmark) }, only: [:create, :destroy]
  before_action :set_bookmarkable, only: [:create, :destroy]
  decorates_assigned :user, :bookmarkables, :bookmarkable

  def index
    bookmarks, @pagination = query.paginate(after: params[:after])
    @bookmarkables = bookmarks.map(&:bookmarkable)
  end

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

  def query
    query = BookmarksQuery.new(@user.bookmarks).with_bookmarkable_type(bookmarkable_type_value)

    if bookmarkable_type == "posts"
      query.includes(bookmarkable: [:user, :community])
    elsif bookmarkable_type == "comments"
      query.includes(bookmarkable: [:user, :post, :community])
    end
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

  helper_method :bookmarkable_types
  def bookmarkable_types
    %w[posts comments]
  end

  helper_method :bookmarkable_type
  def bookmarkable_type
    bookmarkable_types.include?(params[:bookmarkable_type]) ? params[:bookmarkable_type] : "posts"
  end

  def bookmarkable_type_value
    bookmarkable_type.upcase_first.singularize
  end
end
