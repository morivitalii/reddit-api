class Api::Users::Bookmarks::PostsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Bookmarks::PostsPolicy, @user) }

  def index
    posts_ids_query = BookmarksQuery.new(@user.bookmarks).for_posts
    posts_ids_query = posts_ids_query.paginate(
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: after
    )

    posts_ids = posts_ids_query.map(&:bookmarkable_id)

    posts_query = Post.where(id: posts_ids)
    posts_query = posts_query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    posts = posts_query.sort_by { |post| posts_ids.index(post.id) }

    render json: PostSerializer.serialize(posts)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def after
    if params[:after].present?
      query = BookmarksQuery.new(@user.bookmarks).for_posts

      query.where(bookmarkable_id: params[:after]).take
    end
  end
end
