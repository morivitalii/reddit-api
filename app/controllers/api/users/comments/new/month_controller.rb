class Api::Users::Comments::New::MonthController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Comments::New::MonthPolicy, @user) }

  def index
    query = CommentsQuery.new(@user.comments).not_removed
    query = CommentsQuery.new(query).for_the_last_month
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    comments = query.paginate(attributes: [:new_score, :id], after: params[:after])

    render json: CommentSerializer.serialize(comments)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end