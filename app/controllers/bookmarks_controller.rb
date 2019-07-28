# frozen_string_literal: true

class BookmarksController < ApplicationController
  layout "narrow"

  before_action -> { authorize(Bookmark) }
  before_action :set_user, only: [:index]
  before_action :set_thing, only: [:create, :destroy]

  def index
    @records, @pagination_record = Bookmark.type(type).where(user: @user).includes(bookmarkable: [:sub, :user, :post]).paginate(after: params[:after])

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

  def set_thing
    @thing = Thing.find(params[:thing_id])
  end

  def type
    ThingsTypes.new(params[:type]).key&.to_s&.classify
  end
end
