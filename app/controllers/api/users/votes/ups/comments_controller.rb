class Api::Users::Votes::Ups::CommentsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(@user, policy_class: Api::Users::Votes::Ups::CommentsPolicy) }

  def index
    @comments, @pagination = query.paginate(after: params[:after])
  end

  private

  def query
    CommentsQuery.new.up_voted_by_user(@user).includes(:user, :post, :community)
  end

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end
end
