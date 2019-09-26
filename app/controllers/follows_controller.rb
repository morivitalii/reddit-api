# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Follow) }
  decorates_assigned :community

  def create
    CreateFollowService.new(@community, current_user).call

    render json: {follow: true, followers_count: community.followers_count}
  end

  def destroy
    DeleteFollowService.new(@community, current_user).call

    render json: {follow: false, followers_count: community.followers_count}
  end

  private

  def pundit_user
    Context.new(current_user, @community)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end
end
