class Api::Users::Votes::Downs::PostsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Votes::Downs::PostsPolicy, @user) }

  def index
    query = PostsQuery.new.down_voted_by_user(@user)
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    posts = query.paginate(after: params[:after])

    render json: PostSerializer.serialize(posts)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end
