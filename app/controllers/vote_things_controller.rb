# frozen_string_literal: true

class VoteThingsController < BaseThingController
  def create
    VoteThingPolicy.authorize!(:create)

    @form = CreateThingVote.new(vote_params.merge(thing: @thing, current_user: Current.user))

    if @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def vote_params
    params.require(:thing_vote).permit(:type)
  end
end
