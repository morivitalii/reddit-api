# frozen_string_literal: true

class VotesController < ApplicationController
  before_action -> { authorize(Vote) }
  before_action :set_user, only: [:posts, :comments]
  before_action :set_votable, only: [:create, :destroy]
  before_action :set_facade

  def posts
    @records, @pagination = posts_query.paginate(after: params[:after])
    @records = @records.map(&:votable).map(&:decorate)
  end

  def comments
    @records, @pagination = comments_query.paginate(after: params[:after])
    @records = @records.map(&:votable).map(&:decorate)
  end

  def create
    @form = CreateVoteForm.new(vote_params)

    if @form.save
      @votable = @votable.reload
      @votable.vote = @form.vote

      render json: serialized_response(@votable)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteVoteService.new(@votable, current_user).call
    @votable = @votable.reload

    render json: serialized_response(@votable)
  end

  private

  def context
    Context.new(current_user, CommunitiesQuery.new.default.take!)
  end

  def posts_query
    query_class = VotesQuery
    query = query_class.new(@user.votes).posts_votes
    query_class.new(query).search_by_vote_type(vote_type).includes(votable: [:user, :community])
  end

  def comments_query
    query_class = VotesQuery
    query = query_class.new(@user.votes).comments_votes
    query_class.new(query).search_by_vote_type(vote_type).includes(votable: [:user, :post, :community])
  end

  def set_facade
    @facade = VotesFacade.new(context, @user)
  end

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

  def serialized_response(votable)
    serializer_class = "#{votable.class.name}Serializer".constantize
    serializer = serializer_class.new(votable)
    serializer.serializable_hash
  end

  def vote_params
    attributes = policy(Vote).permitted_attributes_for_create

    params.require(:create_vote_form).permit(attributes).merge(votable: @votable, user: current_user)
  end

  def vote_type
    VotesTypes.new(params[:vote_type]).key
  end
end
