# frozen_string_literal: true

class Users::Votes::Ups::PostsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(@user, policy_class: User::Vote::Up::PostPolicy) }
  decorates_assigned :user, :posts

  def index
    @posts, @pagination = query.paginate(after: params[:after])
  end

  private

  def query
    PostsQuery.new.up_voted_by_user(@user).includes(:user, :community)
  end

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end
