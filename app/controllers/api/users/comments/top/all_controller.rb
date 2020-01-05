class Api::Users::Comments::Top::AllController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Comments::Top::AllPolicy, @user) }

  def index
    query = CommentsQuery.new(@user.comments).not_removed
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    comments = query.paginate(attributes: [:top_score, :id], after: params[:after])

    render json: CommentSerializer.serialize(comments)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end
