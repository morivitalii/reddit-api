# frozen_string_literal: true

class Users::PostsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(@user, policy_class: User::PostPolicy) }
  decorates_assigned :user, :posts

  def index
    @posts, @pagination = query.paginate(after: params[:after])
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def query
    PostsQuery.new(@user.posts).not_removed.includes(:community, :user)
  end
end