# frozen_string_literal: true

class ThingBookmarkController < BaseThingController
  def create
    ThingBookmarksPolicy.authorize!(:create)

    CreateThingBookmark.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end

  def destroy
    ThingBookmarksPolicy.authorize!(:destroy)

    DeleteThingBookmark.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end
end
