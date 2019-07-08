# frozen_string_literal: true

class VoteThingsController < ApplicationController
  before_action :set_thing
  before_action -> { authorize(Thing, policy_class: VoteThingPolicy) }

  def create
    @form = CreateThingVote.new(vote_params)

    if @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_thing
    @thing = Thing.find(params[:id])
  end

  def vote_params
    params.require(:thing_vote).permit(:type).merge(thing: @thing, current_user: current_user)
  end
end
