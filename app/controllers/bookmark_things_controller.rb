# frozen_string_literal: true

class BookmarkThingsController < BaseThingController
  before_action -> { authorize(@thing, policy_class: BookmarkThingPolicy) }

  def create
    CreateThingBookmark.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  def destroy
    DeleteThingBookmark.new(thing: @thing, current_user: current_user).call

    head :no_content
  end
end
