class Api::Users::Bookmarks::PostsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Bookmarks::PostsPolicy, @user) }

  def index
    query = PostsQuery.new.bookmarked_by_user(@user)
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    posts = query.paginate(after: params[:after])

    render json: PostSerializer.serialize(posts)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end
