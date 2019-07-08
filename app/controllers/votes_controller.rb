# frozen_string_literal: true

class VotesController < ApplicationController
  layout "narrow", only: [:index]

  before_action -> { authorize(Vote) }
  before_action :set_user, only: [:index]
  before_action :set_navigation_title, only: [:index]
  before_action :set_thing, only: [:create]

  def index
    @records = Vote.include(ReverseChronologicalOrder)
                   .vote_type(helpers.vote_type_filter(params[:vote_type]))
                   .thing_type(helpers.thing_type_filter(params[:thing_type]))
                   .where(user: @user)
                   .includes(thing: [:sub, :user, :post])
                   .joins(:thing)
                   .merge(Thing.not_deleted)
                   .merge(Thing.where.not(user: @user))
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? @user.votes.find_by_id(params[:after]) : nil)
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

  def set_navigation_title
    @navigation_title = @user.username
  end

  def set_thing
    @thing = Thing.find(params[:thing_id])
  end

  def vote_params
    params.require(:thing_vote).permit(:type).merge(thing: @thing, current_user: current_user)
  end
end
