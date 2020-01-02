class Api::Users::CommentsController < ApiApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::CommentsPolicy, @user) }

  def index
    @comments, @pagination = query.paginate(after: params[:after])
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def query
    CommentsQuery.new(@user.comments).not_removed.includes(:community, :user, :post)
  end
end
