# frozen_string_literal: true

class VotesController < ApplicationController
  layout "narrow"

  before_action -> { authorize(Vote) }
  before_action :set_user, only: [:index, :comments]
  before_action :set_votable, only: [:create]

  def index
    @records, @pagination_record = Vote.vote_type(vote_type)
                                       .where(user: @user)
                                       .type("Post")
                                       .includes(votable: [:user, :sub])
                                       .paginate(after: params[:after])

    @records = @records.map(&:votable).map(&:decorate)
  end

  def comments
    @records, @pagination_record = Vote.vote_type(vote_type)
                                       .where(user: @user)
                                       .type("Comment")
                                       .includes(votable: [:user, :post])
                                       .paginate(after: params[:after])

    @records = @records.map(&:votable).map(&:decorate)
  end

  def create
    @form = CreateVote.new(vote_params)

    if @form.save
      type = @form.vote.vote_type
      score = @form.vote.votable.score

      render json: { type: type, score: score }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_votable
    if params[:post_id].present?
      @votable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @votable = Comment.find(params[:comment_id])
    end
  end

  def vote_params
    attributes = policy(Vote).permitted_attributes_for_create

    params.require(:create_vote).permit(attributes).merge(model: @votable, current_user: current_user)
  end

  def vote_type
    VotesTypes.new(params[:vote_type]).key
  end
end
