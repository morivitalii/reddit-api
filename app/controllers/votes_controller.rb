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

  def posts_query
    query = VotesQuery.new(@user.votes).posts_votes
    VotesQuery.new(query).search_by_vote_type(type).includes(votable: [:user, :community])
  end

  def comments_query
    query = VotesQuery.new(@user.votes).comments_votes
    VotesQuery.new(query).search_by_vote_type(type).includes(votable: [:user, :post, :community])
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

  helper_method :type
  def type
    type_options.include?(params[:type]) ? params[:type] : nil
  end

  helper_method :type_options
  def type_options
    %w(up down)
  end
end
