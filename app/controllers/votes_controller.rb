# frozen_string_literal: true

class VotesController < ApplicationController
  before_action -> { authorize(Vote) }
  before_action :set_user, only: [:index, :comments]
  before_action :set_votable, only: [:create, :destroy]
  before_action :set_facade

  def index
    @records, @pagination = posts_scope.paginate(after: params[:after])
    @records = @records.map(&:votable).map(&:decorate)
  end

  def comments
    @records, @pagination = comments_scope.paginate(after: params[:after])
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

  def posts_scope
    VotesQuery.new(scope).filter_by_votable_type("Post").includes(votable: [:user, :sub])
  end

  def comments_scope
    VotesQuery.new(scope).filter_by_votable_type("Comment").includes(votable: [:user, post: :sub])
  end

  def scope
    query_class = VotesQuery
    scope = query_class.new.filter_by_vote_type(vote_type)
    query_class.new(scope).where_user(@user)
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
