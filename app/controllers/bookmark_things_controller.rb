# frozen_string_literal: true

class BookmarkThingsController < ApplicationController
  before_action :set_thing
  before_action -> { authorize(@thing, policy_class: BookmarkThingPolicy) }

  def create
    CreateThingBookmark.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  def destroy
    DeleteThingBookmark.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  private

  def set_thing
    @thing = Thing.find(params[:id])
  end
end
