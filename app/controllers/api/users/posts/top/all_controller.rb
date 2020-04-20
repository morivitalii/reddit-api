class Api::Users::Posts::Top::AllController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Posts::Top::AllPolicy, @user) }

  def index
    query = PostsQuery.new(@user.posts).not_removed
    query = query.includes(:community, :created_by, :edited_by, :approved_by)
    posts = paginate(
      query,
      attributes: [:top_score, :id],
      order: :desc,
      limit: 25,
      after: params[:after].present? ? Post.where(id: params[:after]).take : nil
    )

    render json: PostSerializer.serialize(posts)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def pundit_user
    Context.new(current_user, nil)
  end
end
