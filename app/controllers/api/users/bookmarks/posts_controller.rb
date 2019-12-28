class Api::Users::Bookmarks::PostsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Bookmarks::PostsPolicy, @user) }

  def index
    @posts, @pagination = query.paginate(after: params[:after])
  end

  private

  def query
    PostsQuery.new.bookmarked_by_user(@user).includes(:user, :community)
  end

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end
