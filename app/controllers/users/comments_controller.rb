# frozen_string_literal: true

class Users::CommentsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(@user, policy_class: Users::CommentsPolicy) }
  decorates_assigned :user, :comments

  def index
    @comments, @pagination = query.paginate(after: params[:after])
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def query
    CommentsQuery.new(@user.comments).not_removed.includes(:community, :user)
  end
end