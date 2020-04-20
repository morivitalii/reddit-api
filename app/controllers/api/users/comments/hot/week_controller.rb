class Api::Users::Comments::Hot::WeekController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Comments::Hot::WeekPolicy, @user) }

  def index
    query = CommentsQuery.new(@user.comments).not_removed
    query = CommentsQuery.new(query).for_the_last_week
    query = query.includes(:community, :created_by, :edited_by, :approved_by, post: [:created_by, :community])
    comments = paginate(
      query,
      attributes: [:hot_score, :id],
      order: :desc,
      limit: 25,
      after: params[:after].present? ? Comment.where(id: params[:after]).take : nil
    )

    render json: CommentSerializer.serialize(comments)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def pundit_user
    Context.new(current_user, nil)
  end
end
