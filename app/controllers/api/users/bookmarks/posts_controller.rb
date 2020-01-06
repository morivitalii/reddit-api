class Api::Users::Bookmarks::PostsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Bookmarks::PostsPolicy, @user) }

  def index
    posts_ids = BookmarksQuery.new(@user.bookmarks).for_posts.paginate(after: after).map(&:bookmarkable_id)
    query = Post.where(id: posts_ids)
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    posts = query.sort_by { |post| posts_ids.index(post.id) }

    render json: PostSerializer.serialize(posts)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def after
    if params[:after].present?
      BookmarksQuery.new(@user.bookmarks).for_posts.where(bookmarkable_id: params[:after]).take
    else
      nil
    end
  end
end
