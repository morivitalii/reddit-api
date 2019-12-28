class Api::Users::PostsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::PostsPolicy, @user) }

  def index
    @posts, @pagination = query.paginate(after: params[:after])
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def query
    PostsQuery.new(@user.posts).not_removed.includes(:community, :user)
  end
end
