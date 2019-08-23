# frozen_string_literal: true

class VotesController < ApplicationController
  before_action :set_user
  before_action -> { authorize(@user, policy_class: VotePolicy) }, only: [:posts_index, :comments_index]
  before_action -> { authorize(Vote) }, only: [:create, :destroy]
  before_action :set_votable, only: [:create, :destroy]
  decorates_assigned :user, :posts, :comments, :votable

  def posts_index
    @votes, @pagination = posts_query.paginate(after: params[:after])
    @posts = @votes.map(&:votable)
  end

  def comments_index
    @votes, @pagination = comments_query.paginate(after: params[:after])
    @comments = @votes.map(&:votable)
  end

  def create
    @form = CreateVoteForm.new(vote_params)

    if @form.save
      @votable = @votable.reload
      @votable.vote = @form.vote

      render json: { score: votable.score, up_vote_link: votable.up_vote_link, down_vote_link: votable.down_vote_link }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteVoteService.new(@votable, current_user).call
    @votable = @votable.reload

    render json: { score: votable.score, up_vote_link: votable.up_vote_link, down_vote_link: votable.down_vote_link }
  end

  private

  def posts_query
    query = VotesQuery.new(@user.votes).posts_votes
    VotesQuery.new(query).search_by_vote_type(type).includes(votable: [:user, :community])
  end

  def comments_query
    query = VotesQuery.new(@user.votes).comments_votes
    VotesQuery.new(query).search_by_vote_type(type).includes(votable: [:user, :post, :community])
  end

  def set_user
    @user = params[:user_id].present? ? UsersQuery.new.with_username(params[:user_id]).take! : current_user
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
    params.require(:create_vote_form).permit(attributes).merge(votable: @votable, user: current_user)
  end

  helper_method :type
  def type
    type_options.include?(params[:type]) ? params[:type] : nil
  end

  helper_method :type_options
  def type_options
    %w(up down)
  end
end
