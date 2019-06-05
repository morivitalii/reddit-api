# frozen_string_literal: true

class ThingsActionsController < ApplicationController
  def index
    ThingsActions.authorize!(:index)

    ids = params[:ids].present? ? params[:ids].split(",").map(&:to_i).compact.uniq : []

    return head :no_content if ids.blank? && ids.size > 500

    things = Thing.includes(:sub, :approved_by).where(id: ids).to_a
    votes = Vote.where(thing: things, user: Current.user).to_a
    bookmarks = Bookmark.where(thing: things, user: Current.user).to_a

    things.each do |thing|
      thing.vote = votes.find { |vote| thing.id == vote.thing_id }
      thing.bookmark = bookmarks.find { |bookmark| thing.id == bookmark.thing_id }
    end

    html = render_to_string(partial: "things/actions", collection: things, as: :thing)

    render plain: html
  end
end
