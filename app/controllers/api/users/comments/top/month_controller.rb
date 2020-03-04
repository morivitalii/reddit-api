class Api::Users::Comments::Top::MonthController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Comments::Top::MonthPolicy, @user) }

  def index
    query = CommentsQuery.new(@user.comments).not_removed
    query = CommentsQuery.new(query).for_the_last_month
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    comments = paginate(
      query,
      attributes: [:top_score, :id],
      order: :desc,
      limit: 25,
      after: params[:after]
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
