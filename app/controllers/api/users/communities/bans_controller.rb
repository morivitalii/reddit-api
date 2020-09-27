class Api::Users::Communities::BansController < ApplicationController
  before_action :set_user, only: [:index]
  before_action -> { authorize(Api::Users::Communities::BansPolicy, @user) }

  def index
    query = CommunitiesQuery.new.with_user_banned(@user)
    communities = paginate(
      query,
      attributes: [:url],
      order: :asc,
      limit: 25,
      after: params[:after].present? ? CommunitiesQuery.new.with_url(params[:after]).take : nil
    )

    render json: CommunitySerializer.serialize(communities)
  end

  private

  def set_user
    @user ||= UsersQuery.new.with_username(params[:user_id]).take!
  end

  def pundit_user
    Context.new(current_user, nil)
  end
end