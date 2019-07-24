# frozen_string_literal: true

class VotesController < ApplicationController
  layout "narrow", only: [:index]

  before_action -> { authorize(Vote) }
  before_action :set_user, only: [:index]
  before_action :set_thing, only: [:create]

  def index
    @records = Vote.vote_type(vote_type)
                   .where(user: @user)
                   .joins(:thing)
                   .merge(Thing.not_deleted)
                   .merge(Thing.where.not(user: @user))
                   .merge(Thing.thing_type(thing_type))
                   .includes(thing: [:sub, :user, :post])
                   .reverse_chronologically(after)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:thing)
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
    params.require(:thing_vote).permit(:type).merge(thing: @thing, current_user: current_user)
  end

  def vote_type
    VotesTypes.new(params[:vote_type]).key
  end

  def thing_type
    ThingsTypes.new(params[:thing_type]).key
  end

  def after
    params[:after].present? ? Vote.find_by_id(params[:after]) : nil
  end
end
