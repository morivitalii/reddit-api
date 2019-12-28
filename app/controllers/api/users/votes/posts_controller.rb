class Api::Users::Votes::PostsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(@user, policy_class: Api::Users::Votes::PostsPolicy) }
  decorates_assigned :user

  def index
    @posts, @pagination = query.paginate(after: params[:after])
  end

  private

  def query
    PostsQuery.new.voted_by_user(@user).includes(:user, :community)
  end

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end
