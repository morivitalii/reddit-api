# frozen_string_literal: true

class BookmarkThingsController < BaseThingController
  def create
    BookmarkThingPolicy.authorize!(:create)

    CreateThingBookmark.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  def destroy
    BookmarkThingPolicy.authorize!(:destroy)

    DeleteThingBookmark.new(thing: @thing, current_user: current_user).call

    head :no_content
  end
end
