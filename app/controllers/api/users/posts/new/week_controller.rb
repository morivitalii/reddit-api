class Api::Users::Posts::New::WeekController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Posts::New::WeekPolicy, @user) }

  def index
    query = PostsQuery.new(@user.posts).not_removed
    query = PostsQuery.new(query).for_the_last_week
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    posts = query.paginate(attributes: [:new_score, :id], after: params[:after])

    render json: PostSerializer.serialize(posts)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end
