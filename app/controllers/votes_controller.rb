# frozen_string_literal: true

class VotesController < ApplicationController
  before_action :set_user
  before_action -> { authorize(@user, policy_class: VotePolicy) }, only: [:index]
  before_action -> { authorize(Vote) }, only: [:create, :destroy]
  before_action :set_votable, only: [:create, :destroy]
  decorates_assigned :user, :votables, :votable

  def index
    votes, @pagination = query.paginate(after: params[:after])
    @votables = votes.map(&:votable)
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

  def query
    query = VotesQuery.new(@user.votes).with_votable_type(votable_type_value)
    query = VotesQuery.new(query).search_by_vote_type(vote_type_value)

    if votable_type == "posts"
      query.includes(votable: [:user, :community])
    elsif votable_type == "comments"
      query.includes(votable: [:user, :post, :community])
    end
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

  helper_method :votable_types
  def votable_types
    %w(posts comments)
  end

  helper_method :votable_type
  def votable_type
    votable_types.include?(params[:votable_type]) ? params[:votable_type] : "posts"
  end

  def votable_type_value
    votable_type.upcase_first.singularize
  end

  helper_method :vote_types
  def vote_types
    %w(ups downs)
  end

  helper_method :vote_type
  def vote_type
    vote_types.include?(params[:vote_type]) ? params[:vote_type] : nil
  end

  def vote_type_value
    vote_type&.singularize
  end
end
