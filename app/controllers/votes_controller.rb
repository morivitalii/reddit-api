# frozen_string_literal: true

class VotesController < ApplicationController
  before_action -> { authorize(Vote) }
  before_action :set_votable
  decorates_assigned :votable

  def create
    @form = CreateVoteForm.new(vote_params)

    if @form.save
      @votable = @votable.reload
      @votable.vote = @form.vote

      render json: {score: votable.score, up_vote_link: votable.up_vote_link, down_vote_link: votable.down_vote_link}
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteVoteService.new(@votable, current_user).call
    @votable = @votable.reload

    render json: {score: votable.score, up_vote_link: votable.up_vote_link, down_vote_link: votable.down_vote_link}
  end

  private

  def set_votable
    if params[:post_id].present?
      @votable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @votable = Comment.find(params[:comment_id])
    end
  end

  def vote_params
    attributes = policy(Vote).permitted_attributes_for_create
    params.require(:create_vote_form).permit(attributes).merge(votable: @votable, user: current_user)
  end
end
