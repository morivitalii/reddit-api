class Api::Users::Votes::CommentsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Votes::CommentsPolicy, @user) }

  def index
    comments_ids_query = VotesQuery.new(@user.votes).for_comments
    comments_ids_query = paginate(
      comments_ids_query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: after
    )

    comments_ids = comments_ids_query.map(&:votable_id)

    comments_query = Comment.where(id: comments_ids)
    comments_query = comments_query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by, post: [:created_by], comment: [:created_by])
    comments = comments_query.sort_by { |comment| comments_ids.index(comment.id) }

    render json: CommentSerializer.serialize(comments)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def after
    if params[:after].present?
      query = VotesQuery.new(@user.votes).for_comments

      query.where(votable_id: params[:after]).take
    end
  end

  def pundit_user
    Context.new(current_user, nil)
  end
end
