# frozen_string_literal: true

class ThingVoteController < BaseThingController
  def create
    ThingVotePolicy.authorize!(:create)

    @form = CreateThingVote.new(vote_params.merge(thing: @thing, current_user: Current.user))
    @form.save!

    head :no_content
  end

  private

  def vote_params
    params.require(:thing_vote).permit(:type)
  end
end
