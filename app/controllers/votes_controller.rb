# frozen_string_literal: true

class VotesController < ApplicationController
  layout "narrow", only: [:index]

  before_action -> { authorize(Vote) }
  before_action :set_user, only: [:index]
  before_action :set_thing, only: [:create]

  def index
    @records, @pagination_record = Vote.vote_type(vote_type)
                   .where(user: @user)
                   .type(thing_type)
                   .includes(votable: [:sub, :user, :post])
                   .paginate(attributes: ["#{sort}_score", :id], after: params[:after])

    @records = @records.map(&:votable)
  end

  def create
    @form = CreateVote.new(vote_params)

    if @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_thing
    @thing = Thing.find(params[:thing_id])
  end

  def vote_params
    params.require(:thing_vote).permit(:type).merge(model: @thing, current_user: current_user)
  end

  def vote_type
    VotesTypes.new(params[:vote_type]).key
  end

  def thing_type
    ThingsTypes.new(params[:thing_type]).key&.to_s&.classify
  end
end
