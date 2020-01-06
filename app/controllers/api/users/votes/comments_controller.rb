class Api::Users::Votes::CommentsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Votes::CommentsPolicy, @user) }

  def index
    comments_ids = VotesQuery.new(@user.votes).for_comments.paginate(after: after).map(&:votable_id)
    query = Comment.where(id: comments_ids)
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by, post: [:created_by], comment: [:created_by])
    comments = query.sort_by { |comment| comments_ids.index(comment.id) }

    render json: CommentSerializer.serialize(comments)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def after
    if params[:after].present?
      VotesQuery.new(@user.votes).for_comments.where(votable_id: params[:after]).take
    else
      nil
    end
  end
end
