class Api::Users::Votes::CommentsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Votes::CommentsPolicy, @user) }

  def index
    query = CommentsQuery.new.voted_by_user(@user)
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by, post: [:created_by], comment: [:created_by])
    comments = query.paginate(after: params[:after])

    render json: CommentSerializer.serialize(comments)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end
