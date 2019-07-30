# frozen_string_literal: true

class BookmarksController < ApplicationController
  layout "narrow"

  before_action -> { authorize(Bookmark) }
  before_action :set_user, only: [:index, :comments]
  before_action :set_bookmarkable, only: [:create, :destroy]

  def index
    @records, @pagination_record = Bookmark.type("Post")
                                       .where(user: @user)
                                       .includes(bookmarkable: [:user, :sub])
                                       .paginate(after: params[:after])

    @records = @records.map(&:bookmarkable).map(&:decorate)
  end

  def comments
    @records, @pagination_record = Bookmark.type("Comment")
                                       .where(user: @user)
                                       .includes(bookmarkable: [:user, :post])
                                       .paginate(after: params[:after])

    @records = @records.map(&:bookmarkable).map(&:decorate)
  end

  def create
    CreateBookmark.new(@bookmarkable, current_user).call

    @bookmarkable = @bookmarkable.decorate

    render json: {
      bookmarked: true,
      bookmark_link_tooltip_message: @bookmarkable.bookmark_link_tooltip_message
    }
  end

  def destroy
    DeleteBookmark.new(@bookmarkable, current_user).call

    @bookmarkable = @bookmarkable.decorate

    render json: {
      bookmarked: false,
      bookmark_link_tooltip_message: @bookmarkable.bookmark_link_tooltip_message
    }
  end

  private

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
