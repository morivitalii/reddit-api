class Api::Users::Posts::Top::MonthController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Posts::Top::MonthPolicy, @user) }

  def index
    query = PostsQuery.new(@user.posts).not_removed
    query = PostsQuery.new(query).for_the_last_month
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    posts = query.paginate(
      attributes: [:top_score, :id],
      order: :desc,
      limit: 25,
      after: params[:after]
    )

    render json: PostSerializer.serialize(posts)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end
