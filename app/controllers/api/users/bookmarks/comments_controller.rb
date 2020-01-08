class Api::Users::Bookmarks::CommentsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Bookmarks::CommentsPolicy, @user) }

  def index
    comments_ids_query = BookmarksQuery.new(@user.bookmarks).for_comments
    comments_ids_query.paginate(
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: after
    )

    comments_ids = comments_ids_query.map(&:bookmarkable_id)

    comments_query = Comment.where(id: comments_ids)
    comments_query = comments_query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by, post: [:created_by], comment: [:created_by])
    comments = comments_query.sort_by { |comment| comments_ids.index(comment.id) }

    render json: CommentSerializer.serialize(comments)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def after
    if params[:after].present?
      query = BookmarksQuery.new(@user.bookmarks).for_comments

      query.where(bookmarkable_id: params[:after]).take
    end
  end
end
